import 'package:first_test/components/button.dart';
import 'package:first_test/components/controlSlider.dart';
import 'package:first_test/components/keepButton.dart';
import 'package:first_test/pages/tempDisplayPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _value = false;

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
                    Column(),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        KeepButton(
                            onPressed: handleMain, text: '手動', value: !_value),
                        SizedBox(height: 10),
                        KeepButton(
                            onPressed: handleAuto, text: '自動', value: _value)
                      ],
                    )
                  ],
                )),
            ControlSlider(), //TODO: logic
            Button(onPressed: () => changePage(context), text: '切換頁面')
          ]),
        ));
  }
}
