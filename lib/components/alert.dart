import 'package:first_test/components/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: 測試、打電話權限
class AlertBox extends StatelessWidget {
  VoidCallback? leave;
  AlertBox({super.key, required this.leave()});

  void callPhone() async {
    Uri uri = Uri(scheme: 'tel', path: '0985513233');
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[50],
      content: Container(
        height: 200,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            '系統偵測您已發生車禍',
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
          Text(
            '請問需要撥打電話或緊急連絡人嗎?',
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
          SizedBox(
            height: 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Button(
                onPressed: () => callPhone(),
                text: '打電話',
                disabled: true,
                size: 120),
            SizedBox(
              width: 20,
            ),
            Button(
                onPressed: () => leave!(),
                text: '離開',
                disabled: true,
                size: 120),
          ])
        ]),
      ),
    );
  }
}
