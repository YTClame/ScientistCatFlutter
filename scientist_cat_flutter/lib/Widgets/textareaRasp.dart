import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';


class TextareaRasp extends StatelessWidget {
  TextEditingController _controller;
  Function _callback;
  TextareaRasp(this._callback, [String value]){
    if(value != null)
      _controller = new TextEditingController(text: value);
    else
      _controller = new TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TextField(
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 22,
        ),
        decoration: InputDecoration(fillColor: Color.fromRGBO(247, 245, 204, 1.0), filled: true),
        maxLines: 5,
        cursorColor: Colors.black,
        onChanged: (String s){
          _callback(context, s);
        },
        controller: _controller,
      ),
      width: 300,
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black),
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
