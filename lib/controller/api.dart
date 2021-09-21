import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'firebase_auth.dart';
import 'firebase_storage.dart';

class ApiController extends GetxController {
  final AuthController _authController = Get.find();

  final userName = ''.obs;
  final imagePoint = 0.obs;
  final myPosts = [].obs;
  final rankingPosts = [].obs;

  static const baseUrl = 'http://spino.pigeons.house';

  // プロフィールの登録
  Future createUserInfo(String name, String image) async {
    try {
      var url = Uri.parse(baseUrl + '/api/v1/signup');
      var body = {'name': name, 'img': image};
      var response = await post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ' + _authController.idToken.value,
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      userName.value = name;
    } catch (e) {
      print(e);
    }
  }

  // プロフィールの変更
  Future changeUserInfo(String? name, String? image) async {
    try {
      var url = Uri.parse(baseUrl + '/api/v1/signup');
      var body;
      if (image != null) body = {'img': image};
      if (name != null) body = {'name': name};
      var response = await put(url,
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ' + _authController.idToken.value,
            'Content-Type': 'application/json'
          },
          body: utf8.encode(jsonEncode(body)));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (name != null) userName.value = name;
    } catch (e) {
      print(e);
    }
  }

  // ユーザー情報の取得
  Future getUserInfo(String token) async {
    final StorageController _storageController = Get.find();

    try {
      var url = Uri.parse(baseUrl + '/api/v1/users/me');
      await get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        },
      ).then((response) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        userName.value = result['name'];
        _storageController.downloadAvatar(result['img']);
      });
    } catch (e) {
      print(e);
    }
  }

  // 画像の投稿
  Future postScoringImage(String postUrl) async {
    try {
      var url = Uri.parse(baseUrl + '/api/v1/scoring');
      var body = {
        'image_url': 'gs://summer-scoring-app.appspot.com/' + postUrl
      };
      await post(url,
              headers: {
                'accept': 'application/json',
                'Authorization': 'Bearer ' + _authController.idToken.value,
                'Content-Type': 'application/json'
              },
              body: jsonEncode(body))
          .then((response) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        var point = result['point'];
        imagePoint.value = point;
      });
    } catch (e) {
      print(e);
      Get.back();
      Get.snackbar("エラー", '採点に失敗しました', backgroundColor: Colors.red.shade300);
    }
  }

  // マイギャラリーの取得
  Future getMyGallery(String token) async {
    try {
      var url = Uri.parse(baseUrl + '/api/v1/posts/me');
      await get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      ).then((response) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        myPosts.value = result;
      });
    } catch (e) {
      print(e);
      Get.snackbar("エラー", 'ギャラリーの取得に失敗しました',
          backgroundColor: Colors.red.shade300);
    }
  }

  // ランキングの取得
  Future getRanking(String token) async {
    try {
      var url = Uri.parse(baseUrl + '/api/v1/ranking/posts?limit=10');
      await get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      ).then((response) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        rankingPosts.value = result;
      });
    } catch (e) {
      print(e);
      Get.snackbar("エラー", 'ランキングの取得に失敗しました',
          backgroundColor: Colors.red.shade300);
    }
  }
}
