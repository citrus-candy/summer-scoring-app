import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/index.dart';
import 'screen/profile_registar.dart';
import 'screen/login.dart';
import 'screen/signup.dart';
import 'controller/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());

  runApp(
    GetMaterialApp(
      title: '夏の赤ペン先生',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => TopPage()),
        GetPage(name: '/registar', page: () => ProfileRegistarPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
      ]
    )
  );
}
