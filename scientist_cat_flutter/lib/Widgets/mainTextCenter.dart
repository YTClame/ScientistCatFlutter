import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainTextCenter extends StatelessWidget {
  final String _text;
  MainTextCenter(this._text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        _text,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontFamily: 'MainFont',
          fontSize: 30,
          color: Colors.purple
        ),
      ),
      width: 300,
      margin: EdgeInsets.all(5.0),
    );
  }
}
