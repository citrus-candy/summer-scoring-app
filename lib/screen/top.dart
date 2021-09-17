import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/button.dart';
import '../controller/firebase_auth.dart';

class TopPage extends StatefulWidget{
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State {
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Button(
          buttonText: 'ログアウト', 
          onPressed: () {
            _authController.signOut();
          }
        )
      ),
    );
  }
}