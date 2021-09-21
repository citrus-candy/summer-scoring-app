import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/components/loading_dialog.dart';
import '/controller/api.dart';
import '/controller/firebase_auth.dart';
import '/controller/buttom_navigation_page.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State {
  final _navigationController = Get.put(BottomNavigationPageController());
  final _loadingDialog = LoadingDialog();
  final ApiController _apiController = Get.find();
  final AuthController _authController = Get.find();

  Future getData() async {
    final token = _authController.idToken.value;

    if (_navigationController.currentIndex.value == 0)
      await _apiController.getMyGallery(token);
    else if (_navigationController.currentIndex.value == 1)
      await _apiController.getRanking(token);
    else
      await _apiController.getUserInfo(token);
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
          body: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _navigationController.currentPage;
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
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
