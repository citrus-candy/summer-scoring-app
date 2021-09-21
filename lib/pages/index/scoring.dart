import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './scoring/image_upload.dart';
import './scoring/now_scoring.dart';
import './scoring/result.dart';

class ScoringController extends GetxController {
  final controller = PageController().obs;
}

class ScoringPage extends StatefulWidget {
  @override
  _ScoringPageState createState() => _ScoringPageState();
}

class _ScoringPageState extends State {
  final ScoringController _scoringController = Get.put(ScoringController());
  double pageCount = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: (pageCount == 0.3) ? true : false,
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: PageView(
                controller: _scoringController.controller.value,
                // physics: NeverScrollableScrollPhysics(),
                children: [ImageUpload(), NowScoring(), Result()],
                onPageChanged: (page) {
                  setState(() {
                    if (page == 0)
                      pageCount = 0.3;
                    else if (page == 1)
                      pageCount = 0.6;
                    else
                      pageCount = 1;
                  });
                },
              )),
              LinearProgressIndicator(
                value: pageCount,
                minHeight: 10,
              )
            ],
          ),
        ));
  }
}
