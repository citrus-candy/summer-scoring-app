import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'firebase_auth.dart';

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
}
