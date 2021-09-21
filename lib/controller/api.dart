import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import 'firebase_auth.dart';
import 'firebase_storage.dart';

class ApiController extends GetxController {
  final AuthController _authController = Get.find();
  final StorageController _storageController = Get.find();

  final userName = 'ぺんぎん太郎'.obs;

  static const baseUrl = 'http://spino.pigeons.house';

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

  Future getUserInfo(String token) async {
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
}
