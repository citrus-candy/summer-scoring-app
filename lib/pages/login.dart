import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/button.dart';
import '../controller/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final emailControlller = TextEditingController();
  final passwordControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailControlller.text = 'hogefuga@fuga.com';
    passwordControlller.text = 'hogefuga';

    return Scaffold(
      body: Container(
          color: Theme.of(context).backgroundColor,
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
                        buttonText: 'ログイン',
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          showGeneralDialog(
                              context: context,
                              barrierDismissible: false,
                              transitionDuration: Duration(milliseconds: 250),
                              barrierColor: Colors.black.withOpacity(0.5),
                              pageBuilder: (BuildContext context,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          _authController.signInWithEmailAndPassword(
                              emailControlller.text, passwordControlller.text);
                        }),
                    SizedBox(height: 20),
                    Button(
                        buttonText: 'Googleでログイン',
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _authController.signInWithGoogle();
                        }),
                    Divider(
                      color: Colors.black,
                      height: 50,
                    ),
                    Text('アカウント無かったらユーザー登録してもろて'),
                    SizedBox(height: 20),
                    Button(
                        buttonText: 'ユーザー登録',
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Get.toNamed('/signup');
                        })
                  ],
                )),
              ],
            ),
          )),
    );
  }
}
