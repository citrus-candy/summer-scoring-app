import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TutorialPage extends StatelessWidget {
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: [
          PageModel.withChild(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 200,
                      child: Lottie.asset('assets/animations/image_upload.json',
                          height: 200)),
                  Container(
                    child: Text('画像をアップロードしてください',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  )
                ],
              ),
            ),
            color: Colors.blue,
          ),
          PageModel.withChild(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 200,
                      child: Lottie.asset('assets/animations/ai.json')),
                  Container(
                    child: Text('AIが採点します',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  )
                ],
              ),
              color: Colors.orange,
              doAnimateChild: true),
          PageModel.withChild(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 200,
                      child: Lottie.asset('assets/animations/ranking.json')),
                  Container(
                    child: Text('ランキングで１位を狙おう！',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  )
                ],
              ),
              color: Colors.green,
              doAnimateChild: true),
        ],
        showBullets: true,
        skipText: 'スキップ',
        skipCallback: () {
          (Get.arguments) ? Get.toNamed('/') : Get.back();
        },
        nextText: '次へ',
        finishText: '閉じる',
        finishCallback: () {
          (Get.arguments) ? Get.toNamed('/') : Get.back();
        },
      ),
    );
  }
}
