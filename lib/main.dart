import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/top.dart';
import '../screen/login.dart';
import '../screen/signup.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: '夏の赤ペン先生',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/', page: () => TopPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
      ]
    )
  );
}
