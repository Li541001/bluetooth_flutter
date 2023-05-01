import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('test'),
          backgroundColor: Color.fromARGB(255, 255, 146, 37),
        ),
        body: AddPage());
  }
}

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int _times = 0;
  void addTimes() {
    setState(() {
      _times += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$_times'),
          TextButton(
            onPressed: () => addTimes(),
            child: Text('add'),
            style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
