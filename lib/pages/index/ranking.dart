import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/api.dart';
import '/components/image_card.dart';

class RankingPage extends StatelessWidget {
  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.backgroundColor,
      padding: EdgeInsets.all(2),
      child: Obx(() => (_apiController.rankingPosts.length != 0)
          ? GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 3.0,
              children: [
                  for (var i = 0; i < _apiController.rankingPosts.length; i++)
                    ImageCard(
                        heroTag: (i + 1).toString(),
                        isGallery: false,
                        contents: _apiController.rankingPosts[i])
                ])
          : Center(child: Text('画像がありません', style: TextStyle(fontSize: 20)))),
    );
  }
}
