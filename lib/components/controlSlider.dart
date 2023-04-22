import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlSlider extends StatefulWidget {
  ControlSlider({super.key});
  State<ControlSlider> createState() => _ControlSliderState();
}

class _ControlSliderState extends State<ControlSlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return (Slider(
        min: 0.0,
        max: 100.0,
        value: _value,
        divisions: 5,
        label: '${_value.round()}',
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        }));
  }
}
