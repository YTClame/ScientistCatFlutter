import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/messagerText.dart';

class MessageAW extends StatelessWidget {
  Map<String, dynamic> _message;
  int _myId;

  MessageAW(this._message, this._myId);

  @override
  Widget build(BuildContext context) {
    Alignment alignment = Alignment.center;
    Color backColor = Colors.deepOrange;
    if (_myId == _message['Отправитель']) {
      alignment = Alignment.centerRight;
      backColor = Color.fromRGBO(175, 54, 24, 1.0);
    } else {
      alignment = Alignment.centerLeft;
      backColor = Color.fromRGBO(11, 139, 39, 1.0);
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
