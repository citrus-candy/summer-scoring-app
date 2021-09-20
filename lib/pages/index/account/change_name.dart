import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/components/button.dart';
import '/controller/api.dart';

class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State {
  final nameControlller = TextEditingController();
  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    nameControlller.text = _apiController.userName.value;
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
                  buttonText: '変更',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    await _apiController.changeUserInfo(
                        nameControlller.text, null);

                    Get.toNamed('/', arguments: true);
                    Get.snackbar("通知", 'ユーザー名を変更しました',
                        backgroundColor: Colors.green.shade300);
                  }),
            ],
          ),
        ));
  }
}
