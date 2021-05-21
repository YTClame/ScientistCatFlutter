import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'button.dart';

class AdminOneReport extends StatelessWidget {
  Map<String, dynamic> _info;
  Function _callbackOpenPage; //(BuildContext, Map<String, dynamic>)
  Function _callbackOpenMes; //(BuildContext, Map<String, dynamic>)
  Function _callbackRemoveReport; //(BuildContext, Map<String, dynamic>)

  AdminOneReport(this._info, this._callbackOpenPage, this._callbackOpenMes, this._callbackRemoveReport);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        color: Color.fromRGBO(247, 245, 204, 1.0),
      ),
      child: new Padding(
        padding: EdgeInsets.all(10),
        child: new Column(
          children: [
            Row(
              children: [
                new Text(
                  "Обвинитель: ",
                  style: TextStyle(fontFamily: "MainFont", fontSize: 20),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      _clickToUser(
                          _info['Отправитель'], _info['Роль отправителя'], context);
                    },
                    child: new Text(
                      _info['Фамилия отправителя'] +
                          ' ' +
                          _info['Имя отправителя'],
                      style: TextStyle(
                          fontFamily: "InputFont",
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 5,
            ),
            Row(
              children: [
                new Text(
                  "Обвиняемый: ",
                  style: TextStyle(fontFamily: "MainFont", fontSize: 20),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {_clickToUser(_info['Обвиняемый'], _info['Роль обвиняемого'], context);},
                    child: new Text(
                      _info['Фамилия обвиняемого'] +
                          ' ' +
                          _info['Имя обвиняемого'],
                      style: TextStyle(
                          fontFamily: "InputFont",
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 5,
            ),
            Row(
              children: [
                new Text(
                  "Жалоба: ",
                  style: TextStyle(fontFamily: "MainFont", fontSize: 20),
                ),
                Flexible(
                    child: new Text(
                  _info['Жалоба'],
                  style: TextStyle(fontFamily: "InputFont", fontSize: 16),
                )),
              ],
            ),
            Container(
              height: 5,
            ),
            new ButtonWidget("Их переписка", _pressToOpenMessenger),
            Container(
              height: 5,
            ),
            new ButtonWidget("Удалить", _removeReport),
          ],
        ),
      ),
    );
  }

  void _pressToOpenMessenger(BuildContext context){
    API.loadMesAW(Settings().getToken(), _info['Обвиняемый'], _info['Отправитель']).then((value) => _continueOpenMes(context, value));
  }

  void _continueOpenMes(BuildContext context, List<Map<String, dynamic>> mes){
    Map<String, dynamic> res = new Map<String, dynamic>();
    res['mes'] = mes;
    res['badID'] = _info['Обвиняемый'];
    _callbackOpenMes(context, res);
  }

  void _clickToUser(int id, String role, BuildContext context) {
    Settings().setTempMessenerUserId(id);
    if(role == "Репетитор")
      API.loadInfoAboutTeacher(id.toString()).then((value) => _callbackOpenPage(context, value));
    else if(role == "Ученик")
      API.loadInfoAboutStudent(id.toString()).then((value) => _callbackOpenPage(context, value));
  }

  void _removeReport(BuildContext context){
    API.removeReportAW(Settings().getToken(), _info['ID']).then((value) => _continueReemoveReport(context, value));
  }

  void _continueReemoveReport(BuildContext context, String res){
    if(res == "Error")
      Toast.show("Ошибка удаления жалобы!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    else
      _callbackRemoveReport(context, _info);
  }
}
