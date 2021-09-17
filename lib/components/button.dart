import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({required this.buttonText, required this.onPressed});

  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Text(buttonText, style: TextStyle( fontSize: 20 )),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}