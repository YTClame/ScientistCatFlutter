import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';

class ButtonWidget extends StatelessWidget {
  final String _text;
  final Function ButtonCallback;
  ButtonWidget(this._text, this.ButtonCallback);

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
            ButtonCallback(context);
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
