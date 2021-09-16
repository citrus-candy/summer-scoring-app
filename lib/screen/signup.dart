import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/form_password.dart';
import '../components/form_email.dart';
import '../components/button.dart';

class SignupPage extends StatefulWidget{
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー登録'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Form(child: Column(
                children: [
                  EmailTextFormField(),
                  SizedBox(height: 30),
                  PasswordTextFormField(),
                  SizedBox(height: 30),
                  Button(
                    buttonText: '登録', 
                    onPressed: () {}
                  ),
                  SizedBox(height: 40),
                  Button(
                    buttonText: 'Googleで登録', 
                    onPressed: () {}
                  ),
                ],
              )),
            ],
          ),
        )
      ),
    );
  }
}