import 'dart:async';

import 'package:first_test/components/button.dart';
import 'package:first_test/pages/controlPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  void changePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ControlPage()));
  }

  //TODO: scan bluetooth device

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
                      DropdownButton(
                          items: null, onChanged: null), //TODO: getPairedDevice
                      SizedBox(height: 20),
                      Button(onPressed: null, text: '連接設備'),
                      Button(
                          onPressed: () => changePage(context), text: '切換頁面'),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
    //   return (Scaffold(
    //       appBar: AppBar(
    //         title: Text('連接頁面'),
    //         backgroundColor: Color.fromARGB(255, 255, 146, 37),
    //         elevation: 0.0,
    //       ),
    //       body: Container(
    //         color: Colors.orange[100],
    //         child: Center(
    //             child: Column(children: <Widget>[
    //           Padding(
    //             padding: EdgeInsets.all(20.0),
    //             child: Text(
    //               '霧化玻璃調控系統',
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 30,
    //                   color: Colors.blueGrey[900]),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
    //             child: Image(image: AssetImage('assets/carn.png')),
    //           ),
    //           ControlSlider(),
    //           TextButton(
    //               style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
    //               onPressed: () => changePage1(context),
    //               child: Text(
    //                 '藍芽按鈕',
    //                 style: TextStyle(color: Colors.black),
    //               )),
    //           TextButton(
    //               style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
    //               onPressed: () => changePage2(context),
    //               child: Text(
    //                 '測試按鈕',
    //                 style: TextStyle(color: Colors.black),
    //               )),
    //           Init()
    //         ])),
    //       )));
    // }
  }
}

class Init extends StatefulWidget {
  @override
  State<Init> createState() => InitState();
}

class InitState extends State<Init> {
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

  @override
  void initState() {
    super.initState();
    requestPermission();
    requestPermission2();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('');
  }
}
