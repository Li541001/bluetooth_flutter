import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:first_test/components/button.dart';
import 'package:first_test/main.dart';
import 'package:first_test/pages/bluetooth.dart';
import 'package:first_test/pages/controlPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  bool get isConnected => connection != null && connection!.isConnected;
  int? _deviceState;
  BluetoothDevice? _device;
  String? datas;
  bool _conncted = false;

  //////////////////////////////////////////////////////////////////////////////
  //要求權限
  void requestPermission() async {
    if (await Permission.bluetoothConnect.isGranted) {
      // 已经有蓝牙连接权限
      return;
    }
    if (await Permission.bluetoothConnect.isPermanentlyDenied) {
      // 用户已经拒绝该权限并且不会再次提示
      return;
    }
    if (await Permission.bluetoothConnect.request().isGranted) {
      // 用户已经授予该权限
      return;
    }
    // 用户拒绝了该权限
  }

  void requestPermission2() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.bluetoothScan].request();

    // 检查蓝牙扫描权限状态
    if (statuses[Permission.bluetoothScan] != PermissionStatus.granted) {
      // 如果用户拒绝了权限请求，则显示提示消息
      // 或者禁用应用程序的相关功能。
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    requestPermission();
    requestPermission2();
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

  // _getDeviceItems-------------------------------------------------function
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
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');
      }
    }
  }

  void changePage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ControlPage(connection: connection!)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect'),
        backgroundColor: Color.fromARGB(255, 255, 146, 37),
        elevation: 0.0,
      ),
      body: Container(
          color: Colors.orange[50],
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 65.0, bottom: 30.0),
                  child: Text(
                    '車用智能電控霧化玻璃',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image(image: AssetImage('assets/carn.png'))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (value) => setState(() => _device = value),
                        value: _deviceList.isNotEmpty ? _device : null,
                      ),
                      SizedBox(height: 50),
                      Button(
                        onPressed: () => _conncted ? null : _connect(),
                        text: '連接設備',
                        disabled: !_conncted,
                        size: 200,
                      ),
                      SizedBox(height: 20),
                      Button(
                        onPressed: () => _conncted ? changePage(context) : null,
                        text: '切換頁面',
                        disabled: _conncted,
                        size: 200,
                      )
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
