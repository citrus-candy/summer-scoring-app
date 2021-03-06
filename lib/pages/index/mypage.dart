import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/firebase_auth.dart';
import '/controller/firebase_storage.dart';
import '/controller/api.dart';

class MyPage extends StatelessWidget {
  final ApiController _apiController = Get.find();
  final AuthController _authController = Get.find();
  final StorageController _storageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Get.theme.backgroundColor,
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Obx(() => Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.white,
                      ),
                      child:
                          (_storageController.downloadedAvatarUrl.value != '')
                              ? Image.network(
                                  _storageController.downloadedAvatarUrl.value)
                              : CircularProgressIndicator(),
                    )),
                Text(
                  _apiController.userName.value,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Divider(color: Colors.black),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: Text(
                    'アプリ',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.change_circle),
                  title: Text('テーマの変更'),
                  onTap: () => Get.toNamed('/account/theme'),
                ),
                ListTile(
                  leading: Icon(Icons.quiz),
                  title: Text('チュートリアルを表示'),
                  onTap: () => Get.toNamed('/tutorial', arguments: false),
                ),
              ],
            ),
            Divider(color: Colors.black),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: Text(
                    'アカウント',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('ユーザー名の変更'),
                    onTap: () => Get.toNamed('/account/name')),
                ListTile(
                  leading: Icon(Icons.image_outlined),
                  title: Text('プロフィール画像の変更'),
                  onTap: () => Get.toNamed('/account/image'),
                ),
                // ListTile(
                //   leading: Icon(Icons.vpn_key),
                //   title: Text('パスワードの変更'),
                //   onTap: () =>
                //       _apiController.getUserInfo(_authController.idToken.value),
                // ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('ログアウト'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Text("ログアウトしますか？"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("はい"),
                              onPressed: () => _authController.signOut(),
                            ),
                            TextButton(
                              child: Text("いいえ"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            )
          ]),
        ));
  }
}
