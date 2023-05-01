import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothPage extends StatefulWidget {
  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection? connection;
  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection!.isConnected;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int? _deviceState;

  // initState-------------------------------------------------------function
  @override
  void initState() {
    super.initState();

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0;
    enableBluetooth();
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        getPairedDevices();
      });
    });
  }

  Future<bool> enableBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // getPairedDevices-------------------------------------------------function
  List<BluetoothDevice> _deviceList = [];

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await _bluetooth.getBondedDevices();
    } catch (e) {
      print('error');
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _deviceList = devices;
    });
  }

  // dispose-------------------------------------------------function
  bool isDisconnecting = false;
  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection!.dispose();
      connection = null;
    }
    super.dispose();
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> item = [];
    if (_deviceList.isEmpty) {
      item.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _deviceList.forEach((device) {
        item.add(DropdownMenuItem(
          value: device,
          child: Text('${device.name}'),
        ));
      });
    }
    return item;
  }

  void _connect() async {
    if (_device == null) {
      show('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device!.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _conncted = true;
          });

          connection!.input!.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnecting remotely');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');
      }
    }
  }

  void _disconnect() async {
    await connection!.close();
    show('Device disconnected');

    if (!connection!.isConnected) {
      setState(() {
        _conncted = false;
      });
    }
  }

  bool _conncted = false;
  BluetoothDevice? _device;
  bool _isButtonUnavailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('連接頁面'),
        backgroundColor: Color.fromARGB(255, 255, 146, 37),
        elevation: 0.0,
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              Switch(
                  value: _bluetoothState.isEnabled,
                  onChanged: (bool value) {
                    future() async {
                      if (value) {
                        await FlutterBluetoothSerial.instance.requestEnable();
                      } else {
                        await FlutterBluetoothSerial.instance.requestDisable();
                      }
                      await getPairedDevices();
                      _isButtonUnavailable = false;
                      if (_conncted) {
                        _disconnect();
                      }
                      future().then((_) {
                        setState(() {});
                      });
                    }
                  }),
              DropdownButton(
                items: _getDeviceItems(),
                onChanged: (value) => setState(() => _device = value),
                value: _deviceList.isNotEmpty ? _device : null,
              ),
              ElevatedButton(
                onPressed: _isButtonUnavailable
                    ? null
                    : _conncted
                        ? _disconnect
                        : _connect,
                child: Text(_conncted ? 'Disconnect' : 'Connect'),
              )
            ],
          )
        ],
      )),
    );
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }
}
