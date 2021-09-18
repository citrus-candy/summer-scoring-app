import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/firebase_auth.dart';
import '/controller/buttom_navigation_page.dart';

class TopPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _navigationController = Get.put(BottomNavigationPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(),
          body: _navigationController.currentPage,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _navigationController.currentIndex.value,
              onTap: _navigationController.changePage,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.image), label: "ギャラリー"),
                BottomNavigationBarItem(icon: Icon(Icons.list), label: "ランキング"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "アカウント")
              ]),
        ));
  }
}
