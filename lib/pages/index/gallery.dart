import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/components/image_card.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: [
            for (var i = 1; i < 10; i++)
              ImageCard(
                heroTag: i,
                isGallery: true,
              )
          ]),
    );
  }
}
