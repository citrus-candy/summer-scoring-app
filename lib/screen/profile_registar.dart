import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../components/button.dart';
import '../controller/firebase_auth.dart';

class ProfileRegistarPage extends StatefulWidget{
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State {
  final AuthController _authController = Get.find();
  final nameControlller = TextEditingController();
  static const defaultImage = "https://4.bp.blogspot.com/-CtY5GzX0imo/VCIixcXx6PI/AAAAAAAAmfY/AzH9OmbuHZQ/s170/animal_penguin.png";
  File? _image;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール登録'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
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
                child: (_image == null) ? Image.network(defaultImage) : Image.file(_image!),
              ),
              SizedBox(height: 20),
              Button(
                buttonText: '画像のアップロード', 
                onPressed: () async {
                  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(pickedImage!.path);
                  });
                }
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: nameControlller,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle_outlined),
                    labelText: 'ユーザー名'
                  ),
                )
              ),
              SizedBox(height: 20),
              Button(
                buttonText: '登録', 
                onPressed: () {
                  
                }
              ),
              SizedBox(height: 40),
              Button(
                buttonText: 'ログアウト', 
                onPressed: () {
                  _authController.signOut();
                }
              )
            ]
          )
        ),
      )
    );
  }
}