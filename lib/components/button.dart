import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  bool? disabled = true;
  double? size;
  Button(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.disabled,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: disabled!
                ? Color.fromARGB(255, 217, 170, 116)
                : Colors.blueGrey,
            fixedSize: Size(size!, 75),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: onPressed,
        child: Text(
          '${this.text}',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ));
  }
}
