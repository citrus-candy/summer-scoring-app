import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/components/image_card.dart';


class GalleryPage extends StatelessWidget { 
  static const defaultImage = "https://4.bp.blogspot.com/-CtY5GzX0imo/VCIixcXx6PI/AAAAAAAAmfY/AzH9OmbuHZQ/s170/animal_penguin.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [ 
          for (var i = 0; i < 9; i++) 
            ImageCard(heroTag: i)
        ]
      ),
    );
  }
}