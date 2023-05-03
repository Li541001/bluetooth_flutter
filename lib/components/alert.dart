import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: 測試、打電話權限
class AlertBox extends StatelessWidget {
  void callPhone() async {
    Uri uri = Uri(scheme: 'tel', path: '0985513233');
    await launchUrl(uri);
  }

  void leave(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[50],
      content: Container(
        height: 200,
        child: Column(children: [
          Text(''),
          Row(children: [
            TextButton(onPressed: () => callPhone, child: Text('打電話')),
            TextButton(onPressed: () => leave(context), child: Text('離開'))
          ])
        ]),
      ),
    );
  }
}
