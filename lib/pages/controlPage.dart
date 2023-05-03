import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:first_test/components/button.dart';
import 'package:first_test/components/controlSlider.dart';
import 'package:first_test/components/keepButton.dart';
import 'package:first_test/components/line.dart';
import 'package:first_test/components/waveProgress.dart';
import 'package:first_test/components/windowDisplay.dart';
import 'package:first_test/pages/Gpower.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../main.dart';

//TODO: 離開斷開連線
class ControlPage extends StatefulWidget {
  BluetoothConnection connection;
  ControlPage({super.key, required this.connection});
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _value = false;
  String? img;
  String? imgStatus;
  String? datas;

  void handleMain() {
    sendData('1');
    setState(() {
      _value = false;
    });
  }

  void handleAuto() {
    sendData('2');
    setState(() {
      _value = true;
    });
  }

  void sendData(String text) async {
    Uint8List myUint8List = Uint8List.fromList(utf8.encode(text));
    widget.connection.output.add(myUint8List);
    await widget.connection.output.allSent;
  }

  void changeImg(String data) {
    switch (data) {
      case 'a':
        setState(() {
          img = 'assets/00percentn.png';
          imgStatus = '0';
        });
        break;
      case 'b':
        setState(() {
          img = 'assets/0percentn.png';
          imgStatus = '25';
        });
        break;
      case 'c':
        setState(() {
          img = 'assets/25percentn.png';
          imgStatus = '50';
        });
        break;
      case 'd':
        setState(() {
          img = 'assets/50percentn.png';
          imgStatus = '75';
        });
        break;
      case 'e':
        setState(() {
          img = 'assets/75percentn.png';
          imgStatus = '100';
        });
        break;
    }
  }

  ValueNotifier<double>? valueNotifier;
  ValueNotifier<double>? valueNotifier2;
  double tempValue = 20;
  double lightValue = 30;
  double airValue = 213;

  @override
  void initState() {
    String buffter = '';
    int buffterStatus = 0;
    String asciiText;
    widget.connection.input!.listen((data) {
      asciiText = ascii.decode(data);

      if (asciiText == 'a') {
        changeImg(asciiText);
      } else if (asciiText == 'b') {
        changeImg(asciiText);
      } else if (asciiText == 'c') {
        changeImg(asciiText);
      } else if (asciiText == 'd') {
        changeImg(asciiText);
      } else if (asciiText == 'e') {
        changeImg(asciiText);
      } else if (asciiText == 'x') {
        buffterStatus = 1;
        setState(() {
          airValue = double.parse(buffter);
          airValue = airValue / 1000 * 100;

          valueNotifier2!.value = airValue;
        });

        buffter = '';
      } else if (asciiText == 'y') {
        buffterStatus = 2;

        setState(() {
          try {
            tempValue = double.parse(buffter);
          } catch (e) {
            print("字串轉浮點數");
          }
        });

        buffter = '';
      } else if (asciiText == 'z') {
        buffterStatus = 3;
        setState(() {
          lightValue = double.parse(buffter);
          valueNotifier!.value = lightValue;
        });

        buffter = '';
      } else if (buffterStatus == 1) {
        buffter += asciiText;
      } else if (buffterStatus == 2) {
        buffter += asciiText;
      } else if (buffterStatus == 3) {
        buffter += asciiText;
      }

      setState(() {
        datas = ascii.decode(data);
      });
      print(datas);
    });

    super.initState();
    valueNotifier = ValueNotifier(66.0);
    valueNotifier2 = ValueNotifier(98.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('控制頁面'),
          backgroundColor: Color.fromARGB(255, 255, 146, 37),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Container(
          color: Colors.orange[50],
          child: Column(children: [
            Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    WindowDisplay(img: img, status: imgStatus),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        KeepButton(
                            onPressed: handleMain, text: '手動', value: !_value),
                        SizedBox(height: 20),
                        KeepButton(
                            onPressed: handleAuto, text: '自動', value: _value)
                      ],
                    )
                  ],
                )),
            SizedBox(height: 100),
            Line(
              color: Colors.black,
            ),
            SizedBox(height: 50),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                '手動霧化調整',
                style: TextStyle(fontSize: 20),
              )
            ]),
            ControlSlider(
              action: () => sendData('A'),
              action2: () => sendData('B'),
              action3: () => sendData('C'),
              action4: () => sendData('D'),
              action5: () => sendData('E'),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                '溫度',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '$tempValue°C',
                style: TextStyle(fontSize: 20),
              )
            ]),
            CircleWaveProgress(
              size: 240,
              borderWidth: 10.0,
              backgroundColor: Colors.transparent,
              borderColor: Colors.grey,
              waveColor: Color.fromARGB(181, 33, 149, 243),
              progress: tempValue,
            ),
            SizedBox(height: 20),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                '亮度',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 20,
              ),
            ]),
            SimpleCircularProgressBar(
              size: 200,
              valueNotifier: valueNotifier,
              progressStrokeWidth: 24,
              backStrokeWidth: 24,
              mergeMode: true,
              onGetText: (value) {
                return Text(
                  '${value.toInt()}%',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              progressColors: const [Colors.cyan, Colors.purple],
              backColor: Colors.black.withOpacity(0.4),
            ),
            SizedBox(height: 50),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                '空氣品質',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 20,
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            SimpleCircularProgressBar(
              size: 200,
              valueNotifier: valueNotifier2,
              progressStrokeWidth: 24,
              backStrokeWidth: 24,
              mergeMode: true,
              onGetText: (value) {
                return Text(
                  '${value.toInt()}ppm',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              progressColors: const [Colors.cyan, Colors.purple],
              backColor: Colors.black.withOpacity(0.4),
            ),
            SizedBox(
              height: 40,
            ),
            Button(
              onPressed: () => changePage(context),
              text: '切換頁面',
              disabled: true,
              size: 300,
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        )));
  }

  void changePage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Gpower()));
  }

  @override
  void dispose() {
    valueNotifier!.dispose();
    super.dispose();
  }
}
