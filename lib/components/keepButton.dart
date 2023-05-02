import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeepButton extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  bool value = false;
  KeepButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor:
                value ? Color.fromARGB(255, 217, 170, 116) : Colors.blueGrey,
            fixedSize: Size(120, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: onPressed,
        child: Text(
          '${this.text}',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
        ));
  }
}
