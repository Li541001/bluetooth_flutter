import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'pages/bluetooth.dart';
import 'pages/homePage.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => BluetoothData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class BluetoothData extends ChangeNotifier {
  String _datas = '';
  String get datas => _datas;
  BluetoothConnection? connection;

  void getData() {
    connection!.input!.listen((data) {
      print(_datas);
      _datas = ascii.decode(data);
      notifyListeners();
    });
  }
}
