import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FoundResultText extends StatelessWidget {
  final String _text;
  FoundResultText(this._text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        _text,
        textAlign: TextAlign.start,
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 16,
          height: 1.1,
          color: Colors.white,
        ),
      ),
      width: 320,
      margin: EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 4.0),
    );
  }
}
