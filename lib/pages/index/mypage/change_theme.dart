import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/controller/theme.dart';

class ChangeThemePage extends StatelessWidget {
  final ChangeThemeController _changeThemeController = Get.find();

  Future changeTheme(bool value) async {
    _changeThemeController.changeTheme(value);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSunTheme', value);
    if (value) {
      Get.changeTheme(ThemeData(
          primaryColor: Colors.orange.shade100,
          shadowColor: Colors.orange.shade50,
          backgroundColor: Colors.orange.shade50,
          scaffoldBackgroundColor: Colors.orange.shade50,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange))),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange.shade100,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.orange.shade100,
              selectedItemColor: Colors.orangeAccent.shade700)));
    } else {
      Get.changeTheme(ThemeData(
          primaryColor: Colors.cyan.shade100,
          shadowColor: Colors.cyan.shade50,
          backgroundColor: Colors.cyan.shade50,
          scaffoldBackgroundColor: Colors.cyan.shade50,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.cyan.shade100,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.cyan.shade100,
              selectedItemColor: Colors.cyanAccent.shade700)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'テーマの変更',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Get.theme.appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Obx(() => Container(
          color: Get.theme.backgroundColor,
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () => changeTheme(true),
                    child: Opacity(
                        opacity:
                            _changeThemeController.isSunTheme.value ? 1.0 : 0.5,
                        child: Container(
                            color: Colors.orange.shade100,
                            child: Center(
                                child: Text(
                              'SUN',
                              style: TextStyle(
                                  fontSize:
                                      _changeThemeController.isSunTheme.value
                                          ? 50
                                          : 30,
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 10),
                            )))),
                  )),
              Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () => changeTheme(false),
                    child: Opacity(
                        opacity:
                            _changeThemeController.isSunTheme.value ? 0.5 : 1.0,
                        child: Container(
                            padding: EdgeInsets.all(
                                _changeThemeController.isSunTheme.value
                                    ? 0
                                    : 30),
                            color: Colors.cyan.shade100,
                            child: Center(
                                child: Text('SEA',
                                    style: TextStyle(
                                        fontSize: _changeThemeController
                                                .isSunTheme.value
                                            ? 30
                                            : 50,
                                        fontWeight: FontWeight.w100,
                                        letterSpacing: 10))))),
                  ))
            ],
          ))),
    );
  }
}
