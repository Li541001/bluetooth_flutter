import 'package:first_test/components/controlSlider.dart';
import 'package:flutter/cupertino.dart';
import 'bluetooth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  void changePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FlutterBlueApp()));
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text('連接頁面'),
          backgroundColor: Color.fromARGB(255, 255, 146, 37),
          elevation: 0.0,
        ),
        body: Container(
          color: Colors.orange[100],
          child: Center(
              child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '霧化玻璃調控系統',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blueGrey[900]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              child: Image(image: AssetImage('assets/carn.png')),
            ),
            ControlSlider(),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: () => changePage(context),
                child: Text(
                  '換頁按鈕',
                  style: TextStyle(color: Colors.black),
                ))
          ])),
        )));
  }
}
