import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import 'firebase_auth.dart';

class ApiController extends GetxController {
  final AuthController _authController = Get.find();

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
          body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (name != null) userName.value = name;
    } catch (e) {
      print(e);
    }
  }
}
