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

  bool isAccident = false;

  void leave(context) {
    isAccident = false;
    Navigator.of(context).pop();
  }

  void accidentHappen() {
    isAccident = true;
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox(leave: () => leave(context));
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
        if (datas == 'w' && isAccident == false) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connect'),
          backgroundColor: Color.fromARGB(255, 255, 146, 37),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Container(
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
            Text(
                '緯度: 25.02616 經度: 121.52756'), //台師大: 緯度: 25.02616 經度: 121.52756
            SizedBox(
              height: 5,
            ),
            Text('台北市大安區和平東路一段162號'),
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
        )));
  }
}
