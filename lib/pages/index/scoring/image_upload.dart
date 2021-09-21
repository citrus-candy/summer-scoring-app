import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '/components/button.dart';
import '/controller/firebase_storage.dart';
import '/controller/api.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State {
  final StorageController _storageController = Get.find();
  final ApiController _apiController = Get.find();
  var pickedImage;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
              ),
              child: (_image == null)
                  ? Lottie.asset('assets/animations/image_upload.json',
                      height: 200)
                  : Image.file(_image!),
            ),
            onTap: () async {
              pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage!.path != '') {
                setState(() {
                  _image = File(pickedImage.path);
                });
                print('LocalImagePath : ' + pickedImage.path);
              }
            },
          ),
          SizedBox(height: 20),
          Button(
              buttonText: '画像のアップロード',
              onPressed: () async {
                pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage!.path != '') {
                  setState(() {
                    _image = File(pickedImage.path);
                  });
                  print('LocalImagePath : ' + pickedImage.path);
                }
              }),
          SizedBox(height: 40),
          Button(
              buttonText: '採点',
              onPressed: () async {
                if (pickedImage != null) {
                  var storageUrl =
                      await _storageController.uploadScoringImage(_image!);
                  print(storageUrl);
                } else {
                  Get.snackbar("エラー", '画像をアップロードしてください',
                      backgroundColor: Colors.red.shade300);
                }
              }),
        ],
      ),
    );
  }
}
