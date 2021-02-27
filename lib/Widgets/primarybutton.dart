import 'package:book_worm/animations/fade_animation.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.key, this.text, this.height, this.onPressed})
      : super(key: key);
  Key key;
  String text;
  double height;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      2,
      Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .7),
            ])),
        child: Center(
          child: FlatButton(
            onPressed: () => onPressed,
            child: Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
