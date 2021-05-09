import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/FoundTeacher.dart';
import 'package:scientist_cat_flutter/Pages/LkStudentProfile.dart';
import 'package:scientist_cat_flutter/Pages/LkTeacherProfile.dart';
import 'package:scientist_cat_flutter/Pages/UserStudent.dart';
import 'package:scientist_cat_flutter/Pages/UserTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/drawer.dart';

import '../Settings.dart';
import 'FoundStudent.dart';

enum TypePage {
  LkTeacher,
  LkStudent,
  FoundTeacher,
  FoundStudent,
  UserTeacher,
  UserStudent,
  SecondExUserTeacher,
  SecondExUserStudent,
  Messenger,
  Rasp
}

class LkAdapter extends StatefulWidget {
  final TypePage _tp;

  LkAdapter(this._tp, [BuildContext context, Map<String, dynamic> usInf]) {
    if (usInf == null)
      sss = new LkAdapterState(_tp);
    else
      sss = new LkAdapterState(_tp, context, usInf);
  }

  LkAdapterState sss;

  @override
  createState() => sss;
}

class LkAdapterState extends State<LkAdapter> {
  Map<String, dynamic> _userInfo;
  Map<String, dynamic> _usInf;
  String _title;
  TypePage _tp;
  Widget _mainWidget;
  bool _isTeacher;

  LkAdapterState(this._tp, [BuildContext context, Map<String, dynamic> usInf]) {
    if (usInf != null) _usInf = usInf;
    _userInfo = Settings().getUserInfo();
    if (usInf == null)
      _setTitleAndMainWidget(_tp);
    else
      _setTitleAndMainWidget(_tp, context, _usInf);
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

  void openUserTeacher(BuildContext context, Map<String, dynamic> userInfo) {
    _setTitleAndMainWidget(TypePage.UserTeacher, context, userInfo);
  }

  void openUserStudent(BuildContext context, Map<String, dynamic> userInfo) {
    _setTitleAndMainWidget(TypePage.UserStudent, context, userInfo);
  }

  void _setTitleAndMainWidget(TypePage tp, [BuildContext context, Map<String, dynamic> userInfo]) {
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
        _mainWidget = new FoundStudent(openUserStudent);
        break;
      case TypePage.FoundStudent:
        _title = "Поиск репетитора";
        _mainWidget = new FoundTeacher(openUserTeacher);
        break;
      case TypePage.UserTeacher:
        _title = "";
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              new LkAdapter(TypePage.SecondExUserTeacher, context, userInfo)),
        );
        break;
      case TypePage.UserStudent:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              new LkAdapter(TypePage.SecondExUserStudent, context, userInfo)),
        );
        break;
      case TypePage.SecondExUserTeacher:
        _title = "Профиль репетитора";
        _mainWidget = new UserTeacher(userInfo);
        break;
      case TypePage.SecondExUserStudent:
        _title = "Профиль ученика";
        _mainWidget = new UserStudent(userInfo);
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
    if (this._tp == TypePage.SecondExUserTeacher ||
        this._tp == TypePage.SecondExUserStudent)
      return new WillPopScope(
          onWillPop: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
            appBar: AppBar(title: Text(_title)),
            body: Container(
              child: Center(child: _mainWidget),
              color: Color.fromRGBO(198, 224, 255, 1.0),
            ),
          ),
      );
    else
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

  void _closeUserProfile(BuildContext context) {
    Navigator.pop(context);
  }
}
