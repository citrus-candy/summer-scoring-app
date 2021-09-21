import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  show(context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 250),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  close() {
    Get.back();
  }
}
