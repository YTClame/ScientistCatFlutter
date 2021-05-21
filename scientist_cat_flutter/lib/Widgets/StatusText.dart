import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StatusText extends StatelessWidget {
  final String _text;
  StatusText(this._text);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.yellow;
    if(_text == "Offline")
      color = Colors.red;
    else if(_text == "Online")
      color = Colors.lightGreenAccent;
    return new Container(
      child: new Text(
        _text,
        textAlign: TextAlign.start,
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 16,
          height: 1.1,
          color: color,
        ),
      ),
      width: 320,
      margin: EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 4.0),
    );
  }
}
