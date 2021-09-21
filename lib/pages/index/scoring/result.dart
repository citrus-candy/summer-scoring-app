import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '/controller/api.dart';
import '/controller/firebase_auth.dart';
import '/pages/index/point_detail.dart';
import '/components/button.dart';

class Result extends StatelessWidget {
  static const defaultImage =
      'https://3.bp.blogspot.com/-3zXHhK4EsCc/XLAcx0NOeQI/AAAAAAABSS4/hwoF9buOEJwyh9aE-yMfVSpChdNe9EXQACLcBGAs/s600/bg_himawari_hatake.jpg';
  final ApiController _apiController = Get.find();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Get.theme.backgroundColor,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Lottie.asset('assets/animations/fireworks_1.json', height: 1000),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('採点結果', style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                      _apiController.imagePoint.value.toInt().toString() + '点',
                      style: TextStyle(fontSize: 50)),
                ),
                SizedBox(height: 80),
                Button(
                    buttonText: '詳しく見る',
                    onPressed: () => Get.to(PointDetailPage(
                        heroTag: 'heroTag', image: defaultImage))),
                SizedBox(height: 30),
                Button(
                    buttonText: '閉じる',
                    onPressed: () {
                      Get.back();
                      _apiController
                          .getMyGallery(_authController.idToken.value);
                    }),
              ],
            ),
          ],
        ));
  }
}
