import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';

import '../Settings.dart';

class LkStudentProfile extends StatelessWidget {
  Map<String, dynamic> _userInfo;

  LkStudentProfile() {
    _userInfo = Settings().getUserInfo();
  }

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
          ],
        )),
      ),
    );
  }
}
