import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/FoundTeacher.dart';
import 'package:scientist_cat_flutter/Pages/LkStudentProfile.dart';
import 'package:scientist_cat_flutter/Pages/LkTeacherProfile.dart';
import 'package:scientist_cat_flutter/Widgets/drawer.dart';

import '../Settings.dart';

enum TypePage {
  LkTeacher,
  LkStudent,
  FoundTeacher,
  FoundStudent,
  Messenger,
  Rasp
}

class LkAdapter extends StatefulWidget {
  final TypePage _tp;

  LkAdapter(this._tp);

  @override
  createState() => new LkAdapterState(_tp);
}

class LkAdapterState extends State<LkAdapter> {
  Map<String, dynamic> _userInfo;
  String _title;
  TypePage _tp;
  Widget _mainWidget;
  bool _isTeacher;

  LkAdapterState(this._tp) {
    _userInfo = Settings().getUserInfo();
    _setTitleAndMainWidget(_tp);
  }

  void openLK(BuildContext context) {
    if (Settings().getRole() == "Репетитор")
      _setTitleAndMainWidget(TypePage.LkTeacher);
    else
      _setTitleAndMainWidget(TypePage.LkStudent);
    setState(() {});
  }

  void openFound(BuildContext context) {
    if (Settings().getRole() == "Репетитор")
      _setTitleAndMainWidget(TypePage.FoundTeacher);
    else
      _setTitleAndMainWidget(TypePage.FoundStudent);
    setState(() {});
  }

  void _setTitleAndMainWidget(TypePage tp) {
    switch (tp) {
      case TypePage.LkTeacher:
        _title = "Профиль";
        _mainWidget = new LkTeacherProfile();
        break;
      case TypePage.LkStudent:
        _title = "Профиль";
        _mainWidget = new LkStudentProfile();
        break;
      case TypePage.FoundTeacher:
        _title = "Поиск ученика";
        break;
      case TypePage.FoundStudent:
        _title = "Поиск репетитора";
        _mainWidget = new FoundTeacher();
        break;
      case TypePage.Messenger:
        _title = "Мессенджер";
        break;
      case TypePage.Rasp:
        _title = "Расписание";
        break;
    }
    _isTeacher = Settings().getRole() == "Репетитор" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: Container(
          child: Center(child: _mainWidget),
          color: Color.fromRGBO(198, 224, 255, 1.0),
        ),
        drawer: new DrawerWidget(
            _isTeacher,
            _userInfo['Фамилия'] + " " + _userInfo['Имя'],
            _userInfo['Фото'],
            openLK,
            openFound),
      ),
    );
  }
}
