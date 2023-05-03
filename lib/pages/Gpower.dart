import 'package:first_test/components/alert.dart';
import 'package:first_test/components/button.dart';
import 'package:first_test/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gpower extends StatefulWidget {
  @override
  State<Gpower> createState() => GpowerState();
}

class GpowerState extends State<Gpower> {
  void accidentHappen() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertBox();
        });
  }

  void changePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  //TODO: 重新連線、離開斷開連線
  void connect() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connect'),
          backgroundColor: Color.fromARGB(255, 255, 146, 37),
          elevation: 0.0,
        ),
        body: Container(
          child: Center(
              child: Column(children: [
            Image(image: AssetImage('assets/G.png')),
            SizedBox(
              height: 20,
            ),
            Image(image: AssetImage('assets/mapImg.png')),
            SizedBox(
              height: 5,
            ),
            Text('經緯度'),
            SizedBox(
              height: 5,
            ),
            Text('地址'),
            SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ([
                  Button(
                    onPressed: () => connect,
                    text: '連線',
                    disabled: true,
                    size: 150,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Button(
                    onPressed: () => changePage(context),
                    text: '返回',
                    disabled: true,
                    size: 150,
                  )
                ])),
          ])),
        ));
  }
}
