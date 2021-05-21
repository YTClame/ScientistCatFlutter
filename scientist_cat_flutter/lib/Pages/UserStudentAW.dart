import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/buttonAW.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:scientist_cat_flutter/Widgets/userRasp.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class UserStudentAW extends StatelessWidget {
  Map<String, dynamic> _userInfo;
  Function _callback;

  UserStudentAW(this._userInfo, this._callback);

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
                new UserRasp(),
                new ButtonWidgetAW((){}, _userInfo['Доступ'], _userInfo['ID']),
                new Container(height: 10,),
              ],
            )),
      ),
    );
  }
}
