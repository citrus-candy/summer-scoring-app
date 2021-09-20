import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/index/mypage.dart';
import '/pages/index/gallery.dart';
import '/pages/index/ranking.dart';

class BottomNavigationPageController extends GetxController {
  static BottomNavigationPageController get to => Get.find();

  final currentIndex = 0.obs;

  List<Widget> pages = [
    GalleryPage(),
    RankingPage(),
    MyPage(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int _index) {
    currentIndex.value = _index;
  }
}
