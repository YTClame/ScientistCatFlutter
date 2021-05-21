import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';

class RaspAddButton extends StatelessWidget {
  final String _text;
  final Function _ButtonCallback;
  final String _date;
  RaspAddButton(this._text, this._ButtonCallback, this._date);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 300,
      height: 48,
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black),
        color: Color.fromRGBO(83, 162, 255, 1.0),
      ),
      child: new ElevatedButton(
        onPressed: (){
          _ButtonCallback(context, _date);
        },
        child: new Padding(
          padding: EdgeInsets.only(top: 9.0),
          child: new Text(
            _text,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: 'MainFont',
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
