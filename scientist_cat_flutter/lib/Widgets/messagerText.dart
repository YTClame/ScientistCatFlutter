import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessengerText extends StatelessWidget {
  final String _text;
  final bool _isTime;

  MessengerText(this._text, this._isTime);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.deepOrange;
    double fontSize = 17;
    if(this._isTime){
      color = Color.fromRGBO(255, 240, 112, 1.0);
      fontSize = 14;
    }
    else
      color = Colors.white;
    return new Text(
      _text,
      textAlign: TextAlign.start,
      style: new TextStyle(
        fontFamily: 'InputFont',
        fontSize: fontSize,
        height: 1.1,
        color: color,
      ),
    );
  }
}
