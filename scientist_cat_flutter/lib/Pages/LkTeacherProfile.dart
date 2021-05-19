import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';

import '../Settings.dart';
import 'authWidget.dart';

class LkTeacherProfile extends StatelessWidget {
  Map<String, dynamic> _userInfo;
  Function _editCallback;
  BuildContext __context;

  LkTeacherProfile(this._editCallback) {
    _userInfo = Settings().getUserInfo();
    if(_userInfo["Доступ"] == "Открыт")
      Settings().runOnlineTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _exitIfBlocked();
    });
  }

  void _exitIfBlocked(){
    if(_userInfo["Доступ"] == "Закрыт"){
      Settings().setRole("");
      Settings().setToken("");
      Settings().setUserInfo(null);
      Navigator.pushAndRemoveUntil(
          __context,
          MaterialPageRoute(
              builder: (BuildContext context) => AuthWidget()),
              (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    __context = context;
    return new Container(
      child: SingleChildScrollView(
        child: new Center(
            child: new Column(
          children: [
            Image.network(
                Settings().getHost() + _userInfo['Фото'].substring(1) + "#" + Random().nextInt(100000).toString()),
            new Container(height: 10),
            new MainText("Фамилия"),
            new LkSecondText(_userInfo['Фамилия']),
            new MainText("Имя"),
            new LkSecondText(_userInfo['Имя']),
            new MainText("Дата рождения"),
            new LkSecondText(_userInfo['Дата рождения']),
            new MainText("Образование"),
            new LkSecondText(_userInfo['Образование']),
            new MainText("Стаж"),
            new LkSecondText(_userInfo['Стаж'].toString()),
            new MainText("Ставка в час"),
            new LkSecondText(_userInfo['Ставка'].toString()),
            new MainText("Номер телефона"),
            new LkSecondText(_userInfo['Телефон']),
            new MainText("Email"),
            new LkSecondText(_userInfo['Email']),
            new MainText("Преподаваемые предметы"),
            new Column(
              children: _userInfo["Преподаваемые предметы"]
                  .map<Widget>((lesson) => LkSecondText(lesson))
                  .toList(),
            ),
            new MainText("Формат занятий"),
            new Column(
              children: _userInfo["Формат занятий"]
                  .map<Widget>((format) => LkSecondText(format))
                  .toList(),
            ),
            new MainText("Вид занятий"),
            new Column(
              children: _userInfo["Вид занятий"]
                  .map<Widget>((view) => LkSecondText(view))
                  .toList(),
            ),
            new MainText("О себе"),
            new LkSecondText(_userInfo['О себе']),
            new ButtonWidget("Редактировать", _editCallback),
            new Container(height: 10),
          ],
        )),
      ),
    );
  }
}
