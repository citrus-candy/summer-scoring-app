import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/api.dart';
import '/components/image_card.dart';

class GalleryPage extends StatelessWidget {
  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Get.theme.backgroundColor,
        padding: EdgeInsets.all(2),
        child: Stack(
          children: [
            Obx(() => (_apiController.myPosts.length != 0)
                ? GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: [
                        for (var i = 0; i < _apiController.myPosts.length; i++)
                          ImageCard(
                              heroTag: (i + 1).toString(),
                              isGallery: true,
                              contents: _apiController.myPosts[i])
                      ])
                : Center(
                    child: Text('画像がありません', style: TextStyle(fontSize: 20)))),
            Positioned(
                right: 20,
                bottom: 20,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('採点する'),
                  onPressed: () => Get.toNamed('/scoring'),
                ))
          ],
        ));
  }
}
