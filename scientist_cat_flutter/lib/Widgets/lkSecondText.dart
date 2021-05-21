import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LkSecondText extends StatelessWidget {
  final String _text;
  LkSecondText(this._text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        _text,
        textAlign: TextAlign.start,
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 25,
          height: 1.1,
          color: Color.fromRGBO(0, 117, 255, 1.0),
        ),
      ),
      width: 320,
      margin: EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 4.0),
    );
  }
}
