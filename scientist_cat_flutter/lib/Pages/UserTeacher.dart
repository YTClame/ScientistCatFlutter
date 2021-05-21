import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:scientist_cat_flutter/Widgets/userRasp.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class UserTeacher extends StatelessWidget {
  Map<String, dynamic> _userInfo;
  Function _callback;
  Function _openReport;

  UserTeacher(this._userInfo, this._callback, this._openReport);

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
            new UserRasp(),
            new ButtonWidget("Написать", _addContact),
            new Container(
              height: 10,
            ),
            new ButtonWidget("Пожаловаться", _report),
            new Container(
              height: 10,
            ),
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

  void _report(BuildContext context){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = _userInfo['Фамилия'] + " " + _userInfo['Имя'];
    data['ID'] = _userInfo['ID'];
    _openReport(context, data);
  }
}
