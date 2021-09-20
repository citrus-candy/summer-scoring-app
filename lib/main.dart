import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/index.dart';
import 'pages/profile_registar.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'controller/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _initialRoute = '/login';
  final _authController = Get.put(AuthController());
  await _authController
      .checkLoginState()
      .then((value) => {if (value) _initialRoute = '/'});

  runApp(GetMaterialApp(
      title: '夏の赤ペン先生',
      theme: ThemeData(
          primaryColor: Colors.cyan.shade100,
          shadowColor: Colors.cyan.shade50,
          backgroundColor: Colors.cyan.shade50,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.cyan.shade100,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.cyan.shade100,
              selectedItemColor: Colors.cyanAccent.shade700)),
      initialRoute: _initialRoute,
      getPages: [
        GetPage(name: '/', page: () => TopPage()),
        GetPage(name: '/registar', page: () => ProfileRegistarPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
      ]));
}
