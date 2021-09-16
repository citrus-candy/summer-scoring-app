import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}
class _PasswordTextFormFieldState extends State {
  String password = '';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.vpn_key),
          labelText: 'パスワード'
        ),
        obscureText: true,
        onChanged: (String value) {
          setState(() {
            password = value;
          });
        },
      )
    );
  }
}