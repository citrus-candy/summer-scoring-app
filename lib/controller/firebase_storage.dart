import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_auth.dart';
import '/pages/index/scoring.dart';
import 'api.dart';

class StorageController extends GetxController {
  final AuthController _authController = Get.find();
  final FirebaseStorage storage = FirebaseStorage.instance;

  var uploadedAvatarUrl = ''.obs;
  var downloadedAvatarUrl =
      'https://4.bp.blogspot.com/-CtY5GzX0imo/VCIixcXx6PI/AAAAAAAAmfY/AzH9OmbuHZQ/s170/animal_penguin.png'
          .obs;

  Future uploadAvatar(File file) async {
    try {
      var folderName = _authController.uid.value.substring(0, 4);
      var result = await storage
          .ref('avatars/' + folderName + '/avatar.png')
          .putFile(file);
      print('RemoteImagePath : ' + result.ref.fullPath);
      uploadedAvatarUrl.value = 'avatars/' + folderName + '/avatar.png';
      await downloadAvatar(uploadedAvatarUrl.value);
    } catch (e) {
      print(e);
    }
  }

  Future downloadAvatar(String url) async {
    downloadedAvatarUrl.value = await storage.ref(url).getDownloadURL();
    print(downloadedAvatarUrl.value);
  }

  Future<String> downloadDefaultAvatar(String path) async {
    var url = await storage.ref(path).getDownloadURL();
    return url;
  }

  Future uploadScoringImage(File file) async {
    final ApiController _apiController = Get.find();
    final ScoringController _scoringController = Get.find();
    try {
      _scoringController.controller.value.jumpToPage(1);
      var folderName = _authController.uid.value.substring(0, 4);
      var result = await storage
          .ref('images/' + folderName + '/' + randomString(8) + '.png')
          .putFile(file);
      await _apiController.postScoringImage(result.ref.fullPath);
      _scoringController.controller.value.jumpToPage(2);
      print('RemoteImagePath : ' + result.ref.fullPath);
    } catch (e) {
      print(e);
      Get.back();
      Get.snackbar("エラー", '画像のアップロードに失敗しました',
          backgroundColor: Colors.red.shade300);
    }
  }

  String randomString(int length) {
    const _randomChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;

    final rand = new Random();
    final codeUnits = new List.generate(
      length,
      (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);
      },
    );
    return new String.fromCharCodes(codeUnits);
  }
}
