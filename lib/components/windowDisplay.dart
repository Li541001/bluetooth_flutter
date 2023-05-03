import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WindowDisplay extends StatefulWidget {
  String? img;
  String? status;
  WindowDisplay({super.key, required this.img, required this.status});
  @override
  State<WindowDisplay> createState() => WindowDisplayState();
}

class WindowDisplayState extends State<WindowDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Image.asset(
          "${widget.img}",
          width: 220,
          fit: BoxFit.contain,
        )),
        Text(
          '狀態:' + '${widget.status}' + '%',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
