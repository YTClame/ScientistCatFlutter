import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/messagerText.dart';

class Message extends StatelessWidget {
  Map<String, dynamic> _message;
  int _myId;
  Function _callback;

  Message(this._message, this._myId, this._callback);

  @override
  Widget build(BuildContext context) {
    Alignment alignment = Alignment.center;
    Color backColor = Colors.deepOrange;
    if (_myId == _message['Отправитель']) {
      alignment = Alignment.centerRight;
      backColor = Color.fromRGBO(83, 162, 255, 1.0);
    } else {
      alignment = Alignment.centerLeft;
      backColor = Color.fromRGBO(0, 117, 255, 1.0);
    }
    return new Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: backColor,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        width: 300,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 5),
        child: new Column(
          children: [
            new MessengerText(_message['Сообщение'], false),
            new MessengerText("("+_message['Дата'] + " " + _message['Время'] + ")", true),
          ],
        ),
      ),
    );
  }
}
