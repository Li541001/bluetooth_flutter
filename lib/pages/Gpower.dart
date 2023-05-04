import 'dart:convert';

import 'package:first_test/components/alert.dart';
import 'package:first_test/components/button.dart';
import 'package:first_test/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Gpower extends StatefulWidget {
  BluetoothConnection? connection;
  BluetoothDevice? device;
  Gpower({super.key, required this.connection, required this.device});
  @override
  State<Gpower> createState() => GpowerState();
}

class GpowerState extends State<Gpower> {
  String? datas;

  bool isConnect = false;

  void accidentHappen() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox();
        });
  }

  void changePage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(connection: widget.connection)));
  }

  void connect() async {
    await BluetoothConnection.toAddress(widget.device!.address)
        .then((_connection) {
      widget.connection = _connection;

      widget.connection!.input!.listen((data) {
        datas = ascii.decode(data);
        if (datas == 'w') {
          accidentHappen();
        }
      });
      setState(() {
        isConnect = true;
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred');
      print(error);
    });
  }

  void disconnect() async {
    await widget.connection!.close();
  }

  @override
  void dispose() {
    super.dispose();

    widget.connection!.dispose();
    widget.connection = null;
  }

  @override
  void initState() {
    super.initState();
    disconnect();

    print('isConnect');
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
          child: Center(
              child: Column(children: [
            Image(image: AssetImage('assets/G.png')),
            SizedBox(
              height: 20,
            ),
            Image(image: AssetImage('assets/mapImg.png')),
            SizedBox(
              height: 5,
            ),
            Text('經緯度'),
            SizedBox(
              height: 5,
            ),
            Text('地址'),
            SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ([
                  Button(
                    onPressed: () => isConnect ? null : connect(),
                    text: '連線',
                    disabled: !isConnect,
                    size: 150,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Button(
                    onPressed: () => changePage(context),
                    text: '返回',
                    disabled: true,
                    size: 150,
                  )
                ])),
          ])),
        ));
  }
}
