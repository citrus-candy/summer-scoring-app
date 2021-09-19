import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/index/mypage.dart';
import '../screen/index/gallery.dart';
import '../screen/index/ranking.dart';

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
