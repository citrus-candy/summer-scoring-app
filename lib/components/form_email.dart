import 'package:flutter/material.dart';

class EmailTextFormField extends StatefulWidget {
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}
class _EmailTextFormFieldState extends State {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'メールアドレス'
        ),
        onChanged: (String value) {
          setState(() {
            email = value;
          });
        },
      )
    );
  }
}