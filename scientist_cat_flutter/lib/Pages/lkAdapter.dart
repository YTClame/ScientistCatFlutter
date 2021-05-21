import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/FoundTeacher.dart';
import 'package:scientist_cat_flutter/Pages/LkStudentProfile.dart';
import 'package:scientist_cat_flutter/Pages/LkTeacherProfile.dart';
import 'package:scientist_cat_flutter/Pages/UserStudent.dart';
import 'package:scientist_cat_flutter/Pages/UserTeacher.dart';
import 'package:scientist_cat_flutter/Pages/UserTeacherAW.dart';
import 'package:scientist_cat_flutter/Pages/addRaspElem.dart';
import 'package:scientist_cat_flutter/Pages/adminReports.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';
import 'package:scientist_cat_flutter/Pages/reportToUser.dart';
import 'package:scientist_cat_flutter/Widgets/adminDrawer.dart';
import 'package:scientist_cat_flutter/Widgets/choosePhoto.dart';
import 'package:scientist_cat_flutter/Widgets/drawer.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'Contacts.dart';
import 'FoundStudent.dart';
import 'Messenger.dart';
import 'MessengerAW.dart';
import 'Rasp.dart';
import 'UserStudentAW.dart';
import 'createRaspElem.dart';
import 'editRaspElem.dart';
import 'editStudent.dart';
import 'editTeacher.dart';

enum TypePage {
  LkTeacher,
  EditTeacher,
  LkStudent,
  EditStudent,
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
  EditRaspState,
  EditRaspElem,
  ReportState,
  ReportElem,
  ChoosePhotoState,
  ChoosePhotoElem,
  AdminReports,
  UserStudentAW_State,
  UserTeacherAW_State,
  UserStudentAW_Elem,
  UserTeacherAW_Elem,
  MessengerAW_State,
  MessengerAW_Elem,
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
    API
        .getInfoAboutUserForToken(Settings().getToken(), Settings().getRole())
        .then((value) => _continueOpenLK(context, value));
  }

  void _continueOpenLK(BuildContext context, Map<String, dynamic> res) {
    if (res['Статус'] == "Успех") {
      Settings().setUserInfo(res);
      if (Settings().getRole() == "Репетитор")
        _setTitleAndMainWidget(TypePage.LkTeacher);
      else
        _setTitleAndMainWidget(TypePage.LkStudent);
      setState(() {});
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => new AuthWidget()),
          (Route<dynamic> route) => false);
    }
  }

  void openEdit(BuildContext context) {
    if (Settings().getRole() == "Репетитор") {
      API
          .getInfoAboutUserForToken(Settings().getToken(), "Репетитор")
          .then((value) => {_continueOpenEdit(value)});
    }
    if (Settings().getRole() == "Ученик") {
      API
          .getInfoAboutUserForToken(Settings().getToken(), "Ученик")
          .then((value) => {_continueOpenEdit(value)});
    }
  }

  void _continueOpenEdit(Map<String, dynamic> res) {
    Settings().setUserInfo(res);
    if (Settings().getRole() == "Репетитор")
      _setTitleAndMainWidget(TypePage.EditTeacher);
    else
      _setTitleAndMainWidget(TypePage.EditStudent);
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

  void editRaspElem(BuildContext context, Map<String, dynamic> data) {
    _setTitleAndMainWidget(TypePage.EditRaspState, context, data);
  }

  void openReportPage(BuildContext context, Map<String, dynamic> data) {
    _setTitleAndMainWidget(TypePage.ReportState, context, data);
  }

  void openChoosePhoto(BuildContext context, Map<String, dynamic> data) {
    _setTitleAndMainWidget(TypePage.ChoosePhotoState, context, data);
  }

  void openUserPageAW(BuildContext context, Map<String, dynamic> data) {
    if (data['Роль'] == "Ученик")
      _setTitleAndMainWidget(TypePage.UserStudentAW_State, context, data);
    else if (data["Роль"] == "Репетитор")
      _setTitleAndMainWidget(TypePage.UserTeacherAW_State, context, data);
  }

  void openMessengerAW(BuildContext context, Map<String, dynamic> data) {
    _setTitleAndMainWidget(TypePage.MessengerAW_State, context, data);
  }

  void _setTitleAndMainWidget(TypePage tp,
      [BuildContext context, Map<String, dynamic> userInfo]) {
    switch (tp) {
      case TypePage.LkTeacher:
        _title = "Профиль";
        _mainWidget = new LkTeacherProfile(openEdit);
        break;
      case TypePage.EditTeacher:
        _title = "Редактирование";
        _mainWidget = new EditTeacher(openChoosePhoto, openLK);
        break;
      case TypePage.LkStudent:
        _title = "Профиль";
        _mainWidget = new LkStudentProfile(openEdit);
        break;
      case TypePage.EditStudent:
        _title = "Редактирование";
        _mainWidget = new EditStudent(openChoosePhoto, openLK);
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
        _mainWidget =
            new UserTeacher(userInfo, openMessengerWithUser, openReportPage);
        break;
      case TypePage.SecondExUserStudent:
        _title = "Профиль ученика";
        _mainWidget =
            new UserStudent(userInfo, openMessengerWithUser, openReportPage);
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
        _mainWidget = new Rasp(addRaspElem, createRaspElem, editRaspElem);
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
      case TypePage.EditRaspState:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.EditRaspElem, context, userInfo)),
        );
        break;
      case TypePage.EditRaspElem:
        _title = "Редактировать";
        _mainWidget = new EditRaspElem(userInfo['UpdateF'], userInfo['Дата'],
            userInfo['time1'], userInfo['time2'], userInfo['task']);
        break;
      case TypePage.ReportState:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.ReportElem, context, userInfo)),
        );
        break;
      case TypePage.ReportElem:
        _title = "Жалоба";
        _mainWidget = new ReportToUser(userInfo);
        break;
      case TypePage.ChoosePhotoState:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.ChoosePhotoElem, context, userInfo)),
        );
        break;
      case TypePage.ChoosePhotoElem:
        _title = "Выбрать фото";
        _mainWidget = new ChoosePhoto(userInfo);
        break;
      case TypePage.AdminReports:
        _title = "Жалобы";
        _mainWidget = new AdminReports(openUserPageAW, openMessengerAW);
        break;
      case TypePage.UserTeacherAW_State:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new LkAdapter(
                  TypePage.UserTeacherAW_Elem, context, userInfo)),
        );
        break;
      case TypePage.UserTeacherAW_Elem:
        _title = "Профиль";
        _mainWidget = new UserTeacherAW(userInfo, () {});
        break;
      case TypePage.UserStudentAW_State:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new LkAdapter(
                  TypePage.UserStudentAW_Elem, context, userInfo)),
        );
        break;
      case TypePage.UserStudentAW_Elem:
        _title = "Профиль";
        _mainWidget = new UserStudentAW(userInfo, () {});
        break;
      case TypePage.MessengerAW_State:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  new LkAdapter(TypePage.MessengerAW_Elem, context, userInfo)),
        );
        break;
      case TypePage.MessengerAW_Elem:
        _title = "Переписка";
        _mainWidget = new MessengerAW(userInfo['mes'], userInfo['badID']);
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
        this._tp == TypePage.CreateRaspElem ||
        this._tp == TypePage.EditRaspElem ||
        this._tp == TypePage.ReportElem ||
        this._tp == TypePage.ChoosePhotoElem ||
        this._tp == TypePage.UserTeacherAW_Elem ||
        this._tp == TypePage.UserStudentAW_Elem ||
        this._tp == TypePage.MessengerAW_Elem)
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
    else {
      Widget _drawer;
      if (Settings().getRole() != "Админ")
        _drawer = new DrawerWidget(_isTeacher, _userInfo['Фото'], openLK,
            openFound, loadContacts, openRasp);
      else
        _drawer = new AdminDrawer();
      return new MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text(_title)),
          body: Container(
            child: Center(child: _mainWidget),
            color: Color.fromRGBO(198, 224, 255, 1.0),
          ),
          drawer: _drawer,
        ),
      );
    }
  }
}
