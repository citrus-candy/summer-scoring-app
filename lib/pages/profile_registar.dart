import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/components/button.dart';
import '/controller/firebase_storage.dart';
import '/controller/api.dart';

class ProfileRegistarPage extends StatefulWidget {
  @override
  _ProfileRegistarState createState() => _ProfileRegistarState();
}

class _ProfileRegistarState extends State {
  final nameControlller = TextEditingController();
  final StorageController _storageController = Get.find();
  final ApiController _apiController = Get.find();

  var pickedImage;
  var defaultImage =
      'assets/images/avatars/' + Random().nextInt(11).toString() + '.png';
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('プロフィール登録', style: TextStyle(color: Colors.black)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          // automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          alignment: Alignment.center,
          child: SingleChildScrollView(
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
                      ? Image.asset(defaultImage)
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
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: nameControlller,
                      maxLength: 10,
                      decoration: InputDecoration(
                          icon: Icon(Icons.account_circle_outlined),
                          labelText: 'ユーザー名'),
                    )),
                SizedBox(height: 20),
                Button(
                    buttonText: '登録',
                    onPressed: () {
                      if (nameControlller.text == '')
                        Get.snackbar("エラー", 'ユーザー名を入力してください',
                            backgroundColor: Colors.red.shade300);
                      else {
                        FocusScope.of(context).unfocus();

                        if (pickedImage!.path != '') {
                          _storageController.uploadAvatar(_image!);
                        } else {
                          _storageController.uploadAvatar(File(defaultImage));
                        }
                        _apiController.postUserInfo(nameControlller.text,
                            _storageController.uploadedAvatarUrl.value);

                        Get.toNamed('/tutorial', arguments: true);
                        Get.snackbar("通知", 'プロフィール登録に成功しました',
                            backgroundColor: Colors.green.shade300);
                      }
                    }),
              ])),
        ));
  }
}
