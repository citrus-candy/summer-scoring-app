import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/index/point_detail.dart';

class ImageCard extends StatelessWidget {
  ImageCard({required this.heroTag, required this.isGallery});

  static const defaultImage =
      'https://3.bp.blogspot.com/-3zXHhK4EsCc/XLAcx0NOeQI/AAAAAAABSS4/hwoF9buOEJwyh9aE-yMfVSpChdNe9EXQACLcBGAs/s600/bg_himawari_hatake.jpg';
  final _hasPadding = false.obs;
  final heroTag;
  final isGallery;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Hero(
        tag: heroTag,
        child: Material(
            type: MaterialType.transparency,
            child: AnimatedPadding(
              duration: Duration(milliseconds: 80),
              padding: EdgeInsets.all(_hasPadding.value ? 10 : 0),
              child: GestureDetector(
                  onTapDown: (TapDownDetails downDetails) {
                    _hasPadding.value = true;
                  },
                  onTap: () {
                    _hasPadding.value = false;
                    Get.to(
                        PointDetailPage(heroTag: heroTag, image: defaultImage));
                  },
                  onTapCancel: () {
                    _hasPadding.value = false;
                  },
                  child: _imageCard()),
            ))));
  }

  Widget _imageCard() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: isGallery ? BoxFit.fitHeight : BoxFit.fitWidth,
              image: NetworkImage(defaultImage),
              colorFilter: isGallery
                  ? null
                  : ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.srcATop)),
        ),
        child: isGallery
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 0.95],
                    colors: [Colors.black12, Colors.black54],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('100点',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ],
                ),
              )
            : Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (heroTag == 1)
                        Text(heroTag.toString() + '位',
                            style:
                                TextStyle(fontSize: 30, color: Colors.yellow))
                      else if (heroTag == 2)
                        Text(heroTag.toString() + '位',
                            style: TextStyle(
                                fontSize: 30, color: Colors.grey.shade300))
                      else if (heroTag == 3)
                        Text(heroTag.toString() + '位',
                            style: TextStyle(
                                fontSize: 30, color: Colors.brown.shade200))
                      else
                        Text(heroTag.toString() + '位',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                      Text('100点',
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                    ]),
              ),
      ),
    );
  }
}
