import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/FoundTeacher.dart';
import 'package:scientist_cat_flutter/Pages/LkStudentProfile.dart';
import 'package:scientist_cat_flutter/Pages/LkTeacherProfile.dart';
import 'package:scientist_cat_flutter/Pages/UserStudent.dart';
import 'package:scientist_cat_flutter/Pages/UserTeacher.dart';
import 'package:scientist_cat_flutter/Pages/addRaspElem.dart';
import 'package:scientist_cat_flutter/Widgets/drawer.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'Contacts.dart';
import 'FoundStudent.dart';
import 'Messenger.dart';
import 'Rasp.dart';
import 'createRaspElem.dart';

enum TypePage {
  LkTeacher,
  LkStudent,
  FoundTeacher,
  FoundStudent,
  UserTeacher,
  UserStudent,
  SecondExUserTeacher,
  SecondExUserStudent,
  Contacts,
  Messenger,
  SecondMessenger,
  Rasp,
  AddRaspState,
  AddRaspElem,
  CreateRaspState,
  CreateRaspElem,
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

  void openRasp(BuildContext context) {
    _setTitleAndMainWidget(TypePage.Rasp);
    setState(() {});
  }

  void loadContacts(BuildContext context) {
    _setTitleAndMainWidget(TypePage.Contacts);
  }

  void openMessengerWithUser(
      BuildContext context, Map<String, dynamic> messengerResponse) {
    _setTitleAndMainWidget(TypePage.Messenger, context, messengerResponse);
  }

  void openUserTeacher(BuildContext context, Map<String, dynamic> userInfo) {
    _setTitleAndMainWidget(TypePage.UserTeacher, context, userInfo);
  }

  void openUserStudent(BuildContext context, Map<String, dynamic> userInfo) {
    _setTitleAndMainWidget(TypePage.UserStudent, context, userInfo);
  }

  void addRaspElem(BuildContext context, Map<String, dynamic> date) {
    _setTitleAndMainWidget(TypePage.AddRaspState, context, date);
  }

  void createRaspElem(BuildContext context, Map<String, dynamic> func) {
    _setTitleAndMainWidget(TypePage.CreateRaspState, context, func);
  }

  void _setTitleAndMainWidget(TypePage tp,
      [BuildContext context, Map<String, dynamic> userInfo]) {
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
              builder: (context) => new LkAdapter(
                  TypePage.SecondExUserTeacher, context, userInfo)),
        );
        break;
      case TypePage.UserStudent:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new LkAdapter(
                  TypePage.SecondExUserStudent, context, userInfo)),
        );
        break;
      case TypePage.SecondExUserTeacher:
        _title = "Профиль репетитора";
        _mainWidget = new UserTeacher(userInfo, openMessengerWithUser);
        break;
      case TypePage.SecondExUserStudent:
        _title = "Профиль ученика";
        _mainWidget = new UserStudent(userInfo, openMessengerWithUser);
        break;
      case TypePage.Contacts:
        _title = "Мессенджер";
        API
            .getContacts(Settings().getToken())
            .then((contacts) => {_contactsIsLoaded(contacts)});
        break;
      case TypePage.Messenger:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.SecondMessenger, context, userInfo)),
        );
        break;
      case TypePage.SecondMessenger:
        _title = userInfo['MobileName'];
        _mainWidget = new Messenger(() {}, userInfo['Messages']);
        break;
      case TypePage.Rasp:
        _title = "Расписание";
        _mainWidget = new Rasp(addRaspElem, createRaspElem);
        break;
      case TypePage.AddRaspState:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.AddRaspElem, context, userInfo)),
        );
        break;
      case TypePage.AddRaspElem:
        _title = userInfo['Дата'];
        _mainWidget = new AddRaspElem(userInfo['UpdateF'], userInfo['Дата']);
        break;
      case TypePage.CreateRaspState:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.CreateRaspElem, context, userInfo)),
        );
        break;
      case TypePage.CreateRaspElem:
        _title = "Новая дата";
        _mainWidget = new CreateRaspElem(userInfo['UpdateF']);
        break;
    }
    _isTeacher = Settings().getRole() == "Репетитор" ? true : false;
  }

  _contactsIsLoaded(List<Map<String, dynamic>> contacts) {
    _mainWidget = Contacts(openMessengerWithUser, contacts);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (this._tp == TypePage.SecondExUserTeacher ||
        this._tp == TypePage.SecondExUserStudent ||
        this._tp == TypePage.SecondMessenger ||
        this._tp == TypePage.AddRaspElem ||
        this._tp == TypePage.CreateRaspElem)
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
              openFound,
              loadContacts,
              openRasp),
        ),
      );
  }
}
