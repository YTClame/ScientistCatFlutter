import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';


class TextFieldWidget extends StatelessWidget {
  final bool _isPass;
  Function _callback;
  TextFieldWidget(this._isPass, this._callback);

  @override
  Widget build(BuildContext context) {
    return new Container(
          child: new TextField(
            style: new TextStyle(
              fontFamily: 'InputFont',
              fontSize: 22,
            ),
            decoration: InputDecoration(fillColor: Color.fromRGBO(247, 245, 204, 1.0), filled: true),
            maxLines: 1,
            cursorColor: Colors.black,
            obscureText: _isPass,
            onChanged: (String s){
              _callback(context, s);
            },
          ),
        width: 300,
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black),
        ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
