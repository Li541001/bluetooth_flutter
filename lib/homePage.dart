import 'package:first_test/controlSlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text('test page'),
        backgroundColor: Color.fromARGB(255, 255, 146, 37),
        elevation: 0.0,
      ),
      body: Center(
          child: Column(children: <Widget>[Text('test'), ControlSlider()])),
    ));
  }
}
