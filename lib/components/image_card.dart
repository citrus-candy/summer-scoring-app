import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/firebase_storage.dart';
import '/pages/index/point_detail.dart';

class ImageCard extends StatelessWidget {
  ImageCard(
      {required this.heroTag, required this.isGallery, required this.contents});

  final StorageController _storageController = Get.find();

  final _hasPadding = false.obs;
  final String heroTag;
  final bool isGallery;
  final Map<String, dynamic> contents;
  var downloadUrl;

  @override
  Widget build(BuildContext context) {
    final int point = contents['point'];
    String url = contents['image_url'];
    final String userName = contents['user']['name'];
    final String userImage = contents['user']['img'];

    final splitUrl = url.split('/');
    final storageUrl =
        splitUrl[4] + '/' + splitUrl[5] + '/' + splitUrl[6].split('?')[0];
    print('url:' + storageUrl);

    return FutureBuilder(
        future: downloadImage(storageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Hero(
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
                            Get.to(PointDetailPage(
                                heroTag: heroTag, image: downloadUrl));
                          },
                          onTapCancel: () {
                            _hasPadding.value = false;
                          },
                          child: _imageCard(heroTag, point, downloadUrl)),
                    )));
          } else {
            return Hero(
                tag: heroTag,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Future downloadImage(storageUrl) async {
    await _storageController.downloadScoringImage(storageUrl).then((value) {
      downloadUrl = value;
      // print('url:' + value);
    });
  }

  Widget _imageCard(String heroTag, int point, String url) {
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
              image: NetworkImage(url),
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
                      child: Text(point.toString() + '点',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ],
                ),
              )
            : Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(heroTag.toString() + '位',
                          style: TextStyle(
                              fontSize: 30,
                              color: (heroTag == '1')
                                  ? Colors.yellow
                                  : Colors.white)),
                      Text(point.toString() + '点',
                          style: TextStyle(
                              fontSize: 30,
                              color: (heroTag == '1')
                                  ? Colors.yellow
                                  : Colors.white)),
                    ]),
              ),
      ),
    );
  }
}
