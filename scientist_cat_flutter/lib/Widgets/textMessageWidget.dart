import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';

class TextMessageWidget extends StatelessWidget {
  TextEditingController _controller = new TextEditingController();
  Function _callback;

  TextMessageWidget(this._callback, String value){
    _controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new TextField(
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 22,
        ),
        decoration: InputDecoration(
            fillColor: Color.fromRGBO(247, 245, 204, 1.0), filled: true),
        maxLines: 1,
        cursorColor: Colors.black,
        onChanged: (String s) {
          _callback(context, s);
        },
        controller: _controller,
      ),
    );
  }
}
