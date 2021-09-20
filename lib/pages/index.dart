import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/api.dart';
import '/controller/firebase_auth.dart';
import '/controller/buttom_navigation_page.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State {
  final _navigationController = Get.put(BottomNavigationPageController());
  final ApiController _apiController = Get.find();
  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();
    _apiController.getUserInfo(_authController.idToken.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              titleSpacing: 0.0,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        fit: BoxFit.contain, height: 60)
                  ])),
          body: _navigationController.currentPage,
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              currentIndex: _navigationController.currentIndex.value,
              onTap: _navigationController.changePage,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.image), label: 'マイギャラリー'),
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'ランキング'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'マイページ')
              ]),
        ));
  }
}
