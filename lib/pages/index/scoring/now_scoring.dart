import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NowScoring extends StatefulWidget {
  @override
  _NowScoringState createState() => _NowScoringState();
}

class _NowScoringState extends State {
  var randomAnimation;

  @override
  void initState() {
    super.initState();
    randomAnimation = (Random().nextInt(100) % 2).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Get.theme.backgroundColor,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                child: Lottie.asset(
                    'assets/animations/scoring_' + randomAnimation + '.json',
                    height: 400)),
            Container(
              child: Text('採点中', style: TextStyle(fontSize: 20)),
            ),
          ],
        ));
  }
}
