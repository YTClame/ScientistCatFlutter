import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RaspNameOfDay extends StatelessWidget {
  final String _text;
  RaspNameOfDay(this._text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        _text,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 30,
        ),
      ),
      width: 300,
      margin: EdgeInsets.all(5.0),
    );
  }
}
