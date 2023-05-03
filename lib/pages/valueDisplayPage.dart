import 'package:first_test/pages/tempDisplayPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';

class ValueDisplayPage extends StatelessWidget {
  void changePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TempDisplayPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('亮度、空氣品質顯示'),
        backgroundColor: Color.fromARGB(255, 255, 146, 37),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.orange[50],
        child: Column(children: [
          //TODO: 亮度圖
          //TODO: 空氣品質圖
          Button(
              onPressed: () => changePage(context),
              text: '溫度顯示頁面',
              disabled: true),
        ]),
      ),
    );
  }
}
