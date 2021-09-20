import 'package:get/get.dart';
import 'package:http/http.dart';

import 'firebase_auth.dart';

class ApiController extends GetxController {
  final AuthController _authController = Get.find();

  final userName = 'ぺんぎん太郎'.obs;

  static const baseUrl = 'http://spino.pigeons.house:8000';

  Future postUserInfo(String name, String image) async {
    try {
      var url = Uri.parse(baseUrl + '/api/v1/signup');
      var response = await post(url,
          headers: {'Authorization': 'Bearer ' + _authController.idToken.value},
          body: {'name': name, 'img': image});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      userName.value = name;
    } catch (e) {
      print(e);
    }
  }
}
