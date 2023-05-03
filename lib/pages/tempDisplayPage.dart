import 'package:first_test/components/button.dart';
import 'package:first_test/pages/valueDisplayPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'controlPage.dart';

class TempDisplayPage extends StatelessWidget {
  void changePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ValueDisplayPage()));
  }

  void changePage2(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ControlPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('溫度顯示'),
        backgroundColor: Color.fromARGB(255, 255, 146, 37),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.orange[50],
        child: Column(children: [
          //TODO: wave circle
          Text(''),
          Button(
            onPressed: () => changePage(context),
            text: '數值顯示頁面',
            disabled: true,
          ),
          Button(
              onPressed: () => changePage2(context),
              text: '控制頁面',
              disabled: true)
        ]),
      ),
    );
  }
}
