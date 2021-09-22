import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/components/button.dart';
import '/components/loading_dialog.dart';
import '/controller/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State {
  final AuthController _authController = Get.find();
  final _loadingDialog = LoadingDialog();
  final emailControlller = TextEditingController();
  final passwordControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ユーザー登録',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Get.theme.appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
          color: Get.theme.backgroundColor,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 40),
                Form(
                    child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: emailControlller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              icon: Icon(Icons.email), labelText: 'メールアドレス'),
                        )),
                    SizedBox(height: 30),
                    Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: passwordControlller,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(Icons.vpn_key), labelText: 'パスワード'),
                        )),
                    SizedBox(height: 30),
                    Button(
                        buttonText: '登録',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          // ローディング画面
                          _loadingDialog.show(context);
                          await _authController.createUserWithEmailAndPassword(
                              emailControlller.text, passwordControlller.text);
                          await _authController
                              .signInWithEmailAndPassword(emailControlller.text,
                                  passwordControlller.text)
                              .then((_) {
                            Get.toNamed('/registar');
                            Get.snackbar("通知", "ユーザー登録に成功しました",
                                backgroundColor: Colors.green.shade300);
                          });
                        })
                  ],
                )),
              ],
            ),
          )),
    );
  }
}
