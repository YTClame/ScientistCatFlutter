import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainText extends StatelessWidget {
  final String _text;
  MainText(this._text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        _text,
        textAlign: TextAlign.start,
        style: new TextStyle(
          fontFamily: 'MainFont',
          fontSize: 30,
        ),
      ),
      width: 300,
      margin: EdgeInsets.all(5.0),
    );
  }
}
