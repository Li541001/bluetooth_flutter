import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlSlider extends StatefulWidget {
  VoidCallback action, action2, action3, action4, action5;
  ControlSlider(
      {super.key,
      required this.action,
      required this.action2,
      required this.action3,
      required this.action4,
      required this.action5});
  State<ControlSlider> createState() => _ControlSliderState();
}

class _ControlSliderState extends State<ControlSlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return (Slider(
        activeColor: Color.fromARGB(255, 253, 185, 116),
        thumbColor: Color.fromARGB(255, 255, 146, 37),
        inactiveColor: Colors.grey,
        min: 0.0,
        max: 100.0,
        value: _value,
        divisions: 4,
        label: '${_value.round()}',
        onChanged: (value) {
          print(value);
          if (value == 0.0) {
            widget.action();
          } else if (value == 25.0) {
            widget.action2();
          } else if (value == 50.0) {
            widget.action3();
          } else if (value == 75.0) {
            widget.action4();
          } else if (value == 100.0) {
            widget.action5();
          }
          setState(() {
            _value = value;
          });
        }));
  }
}
