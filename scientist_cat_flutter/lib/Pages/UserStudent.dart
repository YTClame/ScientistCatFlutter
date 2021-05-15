import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class UserStudent extends StatelessWidget {
  Map<String, dynamic> _userInfo;
  Function _callback;

  UserStudent(this._userInfo, this._callback);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: SingleChildScrollView(
        child: new Center(
            child: new Column(
              children: [
                Image.network(
                    Settings().getHost() + _userInfo['Фото'].substring(1)),
                new Container(height: 10),
                new MainText("Фамилия"),
                new LkSecondText(_userInfo['Фамилия']),
                new MainText("Имя"),
                new LkSecondText(_userInfo['Имя']),
                new MainText("Дата рождения"),
                new LkSecondText(_userInfo['Дата рождения']),
                new MainText("Класс"),
                new LkSecondText(_userInfo['Класс'].toString()),
                new MainText("Номер телефона"),
                new LkSecondText(_userInfo['Телефон']),
                new MainText("Email"),
                new LkSecondText(_userInfo['Email']),
                new MainText("Изучаемые предметы"),
                new Column(
                  children: _userInfo["Изучаемые предметы"]
                      .map<Widget>((lesson) => LkSecondText(lesson))
                      .toList(),
                ),
                new MainText("Формат занятий"),
                new Column(
                  children: _userInfo["Формат занятий"]
                      .map<Widget>((format) => LkSecondText(format))
                      .toList(),
                ),
                new MainText("О себе"),
                new LkSecondText(_userInfo['О себе']),
                new ButtonWidget("Написать", _addContact),
                new Container(height: 10,),
                new ButtonWidget("Пожаловаться", (){}),
                new Container(height: 10,),
              ],
            )),
      ),
    );
  }

  void _addContact(BuildContext context){
    Settings().setTempMessenerUserId(_userInfo['ID']);
    API.createContact(Settings().getToken(), _userInfo['ID']).then((value) => _writeToUser(context, value));
  }

  void _writeToUser(BuildContext context, String res){
    if(res == "Error"){
      Toast.show("Ошибка добавления контакта!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    API.loadMesseges(Settings().getToken(), _userInfo['ID']).then((value) => _openMessenger(context, value));
  }

  void _openMessenger(BuildContext context, Map<String, dynamic> res){
    _callback(context, res);
  }

}
