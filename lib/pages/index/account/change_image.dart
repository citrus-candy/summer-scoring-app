import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/components/button.dart';
import '/controller/api.dart';
import '/controller/firebase_storage.dart';

class ChangeImagePage extends StatefulWidget {
  @override
  _ChangeImagePageState createState() => _ChangeImagePageState();
}

class _ChangeImagePageState extends State {
  final nameControlller = TextEditingController();
  final ApiController _apiController = Get.find();
  final StorageController _storageController = Get.find();

  var pickedImage;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ユーザー名の変更',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
          color: Theme.of(context).backgroundColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                ),
                child: (_image == null)
                    ? Image.network(
                        _storageController.downloadedAvatarUrl.value)
                    : Image.file(_image!),
              ),
              SizedBox(height: 20),
              Button(
                  buttonText: '画像のアップロード',
                  onPressed: () async {
                    pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedImage!.path != '') {
                      setState(() {
                        _image = File(pickedImage.path);
                      });
                      print('LocalImagePath : ' + pickedImage.path);
                    }
                  }),
              SizedBox(height: 40),
              Button(
                  buttonText: '変更',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (pickedImage != null) {
                      await _storageController.uploadAvatar(_image!);
                      await _apiController.changeUserInfo(
                          null, _storageController.uploadedAvatarUrl.value);
                    }

                    Get.toNamed('/', arguments: true);
                    Get.snackbar("通知", 'プロフィール画像を変更しました',
                        backgroundColor: Colors.green.shade300);
                  }),
            ],
          ),
        ));
  }
}
