import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/button.dart';

class TopPage extends StatefulWidget{
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Button(
          buttonText: 'ログアウト', 
          onPressed: () {
            Get.toNamed('/login');
          }
        )
      ),
    );
  }
}