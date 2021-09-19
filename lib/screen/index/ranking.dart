import 'package:flutter/cupertino.dart';

import '/components/image_card.dart';

class RankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3.0,
          children: [
            for (var i = 1; i < 10; i++)
              ImageCard(
                heroTag: i,
                isGallery: false,
              )
          ]),
    );
  }
}
