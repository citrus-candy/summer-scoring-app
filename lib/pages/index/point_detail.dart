import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/firebase_storage.dart';

class PointDetailPage extends StatelessWidget {
  PointDetailPage(
      {this.heroTag, this.image, this.userName, this.userImage, this.point});

  final StorageController _storageController = Get.find();
  final heroTag;
  final image;
  final userName;
  final userImage;
  final point;
  var downloadUrl;
  static const pointDetails = [
    ['ひまわり', '50'],
    ['そら', '30'],
    ['くも', '20'],
    ['ひまわり', '50'],
    ['そら', '30'],
    ['くも', '20'],
    ['ひまわり', '50'],
    ['そら', '30'],
    ['くも', '20'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Hero(
          tag: heroTag,
          child: Material(
              type: MaterialType.transparency,
              child: SingleChildScrollView(
                child: Stack(children: [
                  Container(
                      color: Colors.white,
                      child: Column(children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height - 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(image),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                          color: Get.theme.primaryColor,
                          child: SingleChildScrollView(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                FutureBuilder(
                                    future: downloadImage(userImage),
                                    builder: (_, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          margin: EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.black, width: 1),
                                            color: Colors.white,
                                          ),
                                          child: Image.network(downloadUrl),
                                        );
                                      } else {
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          margin: EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.black, width: 1),
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                    }),
                                Text(userName, style: TextStyle(fontSize: 20)),
                              ]),
                              Container(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(point + '点',
                                      style: TextStyle(fontSize: 20)))
                            ],
                          )),
                        ),
                        // pointList(context)
                      ])),
                  closeButton()
                ]),
              ))),
    );
  }

  Future downloadImage(storageUrl) async {
    await _storageController.downloadScoringImage(storageUrl).then((value) {
      downloadUrl = value;
    });
  }

  Widget closeButton() {
    return Positioned(
      top: 40,
      right: 10,
      child: ElevatedButton(
        onPressed: () => Get.back(),
        child: Icon(Icons.close),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shape: CircleBorder(
            side: BorderSide(
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  Widget pointList(context) {
    var rows = [];
    pointDetails.forEach((detail) {
      rows.add(DataRow(
        cells: [
          DataCell(Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(detail[0]),
          )),
          DataCell(Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(detail[1] + '点'),
          )),
        ],
      ));
    });

    return ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height / 2),
        child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Get.theme.shadowColor),
          columns: [
            DataColumn(label: Text('単語')),
            DataColumn(label: Text('点数')),
          ],
          rows: List.generate(rows.length, (index) => rows[index]),
        ));
  }
}
