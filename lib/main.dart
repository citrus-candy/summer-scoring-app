import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/index.dart';
import 'pages/profile_registar.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/tutorial.dart';
import 'pages/index/scoring.dart';
import 'pages/index/mypage/change_image.dart';
import 'pages/index/mypage/change_name.dart';
import 'pages/index/mypage/change_theme.dart';
import 'controller/firebase_auth.dart';
import 'controller/firebase_storage.dart';
import 'controller/api.dart';
import 'controller/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _initialRoute = '/login';

  final _authController = Get.put(AuthController());
  await _authController
      .checkLoginState()
      .then((value) => {if (value) _initialRoute = '/'});

  Get.lazyPut(() => ApiController());
  Get.lazyPut(() => StorageController());

  final _changeThemeController = Get.put(ChangeThemeController());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var theme = prefs.getBool('isSunTheme') ?? false;
  _changeThemeController.isSunTheme.value = theme;

  runApp(GetMaterialApp(
      title: '夏の赤ペン先生',
      theme: _changeThemeController.isSunTheme.value
          ? ThemeData(
              primaryColor: Colors.orange.shade100,
              shadowColor: Colors.orange.shade50,
              backgroundColor: Colors.orange.shade50,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange))),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.orange.shade100,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.orange.shade100,
                  selectedItemColor: Colors.orangeAccent.shade700))
          : ThemeData(
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
      // initialRoute: '/account/theme',
      getPages: [
        GetPage(name: '/', page: () => TopPage()),
        GetPage(name: '/scoring', page: () => ScoringPage()),
        GetPage(name: '/registar', page: () => ProfileRegistarPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/tutorial', page: () => TutorialPage()),
        GetPage(name: '/account/image', page: () => ChangeImagePage()),
        GetPage(name: '/account/name', page: () => ChangeNamePage()),
        GetPage(name: '/account/theme', page: () => ChangeThemePage()),
      ]));
}
