import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/firebase_auth.dart';

class MyPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  static const defaultImage =
      "https://4.bp.blogspot.com/-CtY5GzX0imo/VCIixcXx6PI/AAAAAAAAmfY/AzH9OmbuHZQ/s170/animal_penguin.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white,
              ),
              child: Image.network(defaultImage),
            ),
            Text(
              'ぺんぎん太郎',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        Divider(color: Colors.black),
        ListView(
          shrinkWrap: true,
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
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.image_outlined),
              title: Text('プロフィール画像の変更'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('パスワードの変更'),
              onTap: () {},
            ),
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
    );
  }
}
