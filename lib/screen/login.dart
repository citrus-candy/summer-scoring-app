import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/form_password.dart';
import '../components/form_email.dart';
import '../components/button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State {
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              SizedBox(height: 40),
              Form(child: Column(
                children: [
                  EmailTextFormField(),
                  SizedBox(height: 30),
                  PasswordTextFormField(),
                  SizedBox(height: 30),
                  Button(
                    buttonText: 'ログイン', 
                    onPressed: () {
                      Get.toNamed('/');
                    }
                  ),
                  SizedBox(height: 20),
                  Button(
                    buttonText: 'Googleでログイン', 
                    onPressed: () {}
                  ),
                  Divider(
                    color: Colors.black,
                    height: 50,
                  ),
                  Text('アカウント無かったらユーザー登録してもろて'),
                  SizedBox(height: 20),
                  Button(
                    buttonText: 'ユーザー登録', 
                    onPressed: () => Get.toNamed('/signup')
                  )
                ],
              )),
            ],
          ),
        )
      ),
    );
  }
}