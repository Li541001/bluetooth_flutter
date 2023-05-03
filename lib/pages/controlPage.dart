import 'dart:async';
import 'dart:convert';

import 'package:first_test/components/button.dart';
import 'package:first_test/components/controlSlider.dart';
import 'package:first_test/components/keepButton.dart';
import 'package:first_test/components/line.dart';
import 'package:first_test/components/windowDisplay.dart';
import 'package:first_test/pages/tempDisplayPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _value = false;
  String? img;
  String? imgStatus;
  String? datas;

  //TODO: 手動
  void handleMain() {
    setState(() {
      _value = false;
    });
  }

  //TODO: 自動
  void handleAuto() {
    setState(() {
      _value = true;
    });
  }

  void changePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TempDisplayPage()));
  }

  // void changeImg(String data) {
  //   print('!!!!!!!!!!!!!!!!!!${data}');
  //   switch (data) {
  //     case 'a':
  //       setState(() {
  //         img = 'assets/00percentn.png';
  //         imgStatus = '0';
  //       });
  //       break;
  //     case 'b':
  //       setState(() {
  //         img = 'assets/0percentn.png';
  //         imgStatus = '25';
  //       });
  //       break;
  //     case 'c':
  //       setState(() {
  //         img = 'assets/25percentn.png';
  //         imgStatus = '50';
  //       });
  //       break;
  //     case 'd':
  //       setState(() {
  //         img = 'assets/50percentn.png';
  //         imgStatus = '75';
  //       });
  //       break;
  //     case 'e':
  //       setState(() {
  //         img = 'assets/75percentn.png';
  //         imgStatus = '100';
  //       });
  //       break;
  //   }
  // }

  @override
  void initState() {
    final testData = Provider.of<BluetoothData>(context, listen: false);
    testData.getData;
    print(testData.datas);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('控制頁面'),
          backgroundColor: Color.fromARGB(255, 255, 146, 37),
          elevation: 0.0,
        ),
        body: Container(
          color: Colors.orange[50],
          child: Column(children: [
            Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    //TODO: windowDisplay
                    WindowDisplay(img: 'assets/50percentn.png', status: '75'),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        KeepButton(
                            onPressed: handleMain, text: '手動', value: !_value),
                        SizedBox(height: 20),
                        KeepButton(
                            onPressed: handleAuto, text: '自動', value: _value)
                      ],
                    )
                  ],
                )),
            SizedBox(height: 100),
            Line(
              color: Colors.black,
            ),
            SizedBox(height: 80),
            ControlSlider(),
            SizedBox(height: 80),
            Button(
              onPressed: () => changePage(context),
              text: '切換頁面',
              disabled: true,
            )
          ]),
        ));
  }
}
