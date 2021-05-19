import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/newTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesFormatLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesFormatLessonsForStudent.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesViewLessons.dart';
import 'package:scientist_cat_flutter/Widgets/droppedList.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:scientist_cat_flutter/Widgets/secondSex.dart';
import 'package:scientist_cat_flutter/Widgets/textField.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/textareaRasp.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'lkAdapter.dart';

//Каллбеки:
String _city = "";
String _secondName = "";
String _firstName = "";
String _birthday = "";
String _class = "";
String _sex = "";
List<String> _formatLessons = [];
String _phone = "";
String _password = "";
String _email = "";
List<String> _lessons = [];
String _about = "";
File _image = null;

void cityChanged(BuildContext context, String text) {
  _city = text;
}

void textChangedSecondName(BuildContext context, String text) {
  _secondName = text;
}

void textChangedFirstName(BuildContext context, String text) {
  _firstName = text;
}

void textChangedBirthday(BuildContext context, String text) {
  _birthday = text;
}

void classChanged(BuildContext context, String text) {
  _class = text;
}

void sexChanged(BuildContext context, String text) {
  _sex = text;
}

void formatLessonsChanged(BuildContext context, List<String> formats) {
  _formatLessons = formats;
}

void phoneChanged(BuildContext context, String text) {
  _phone = text;
}

void passwordChanged(BuildContext context, String text) {
  _password = text;
}

void emailChanged(BuildContext context, String text) {
  _email = text;
}

void lessonsChanged(BuildContext context, List<String> lessons) {
  _lessons = lessons;
}

void aboutChanged(BuildContext context, String text) {
  _about = text;
}

void clickRegisterButton(BuildContext context) {
  API
      .editStudent(
          _image,
          _city,
          _secondName,
          _firstName,
          _birthday,
          _formatLessons,
          _sex,
          _phone,
          _password,
          _email,
          _lessons,
          _about,
          _class)
      .then((value) => _handleRes(context, value));
}

void _handleRes(BuildContext context, String res) {
  if (res == "0") {
    API
        .getInfoAboutUserForToken(Settings().getToken(), Settings().getRole())
        .then((value) => {_continueSave(context, value)});
  } else {
    Toast.show(res, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}

void _continueSave(BuildContext context, Map<String, dynamic> res) {
  Settings().setUserInfo(res);
  _openLkCallback(context);
}

Function _openChoosePhotoCallback;
Function _openLkCallback;

void _clickChoosePhotoButton(BuildContext context) {
  Map<String, dynamic> map = new Map<String, dynamic>();
  map['UploadCallback'] = _uploadCallback;
  map['Image'] = _image;
  _openChoosePhotoCallback(context, map);
}

void _uploadCallback(BuildContext context, File file) {
  _image = file;
}

class EditStudent extends StatelessWidget {
  Map<String, dynamic> _userInfo;
  DroppedList citiesList;
  DroppedList classList;

  EditStudent(Function openChoosePhotoCallback, Function openLKCallback) {
    _openLkCallback = openLKCallback;
    _openChoosePhotoCallback = openChoosePhotoCallback;
    _userInfo = Settings().getUserInfo();
    citiesList = new DroppedList(
        Settings().getCities(), _userInfo['Город'], cityChanged);
    classList = new DroppedList(
        ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'],
        _userInfo['Класс'].toString(),
        classChanged);
    _secondName = _userInfo['Фамилия'];
    _firstName = _userInfo['Имя'];
    _birthday = _userInfo['Дата рождения'];
    _phone = _userInfo['Телефон'];
    _email = _userInfo['Email'];
    _about = _userInfo['О себе'];
    _formatLessons = new List<String>.from(_userInfo["Формат занятий"]);
    _lessons = new List<String>.from(_userInfo['Изучаемые предметы']);
    _sex = _userInfo['Пол'] == "М" ? "Мужской" : "Женский";
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Center(
        child: new Column(
          children: [
            new Container(
              height: 15.0,
            ),
            new Container(
              child: new Text(
                "Редактирование профиля",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontFamily: 'MainFont',
                  fontSize: 30,
                ),
              ),
              width: 300,
              margin: EdgeInsets.all(5.0),
            ),
            new MainText("Ваш город"),
            citiesList,
            new MainText("Фамилия"),
            new TextFieldWidget(false, textChangedSecondName, _secondName),
            new MainText("Имя"),
            new TextFieldWidget(false, textChangedFirstName, _firstName),
            new MainText("Дата рождения"),
            new TextFieldWidget(false, textChangedBirthday, _birthday),
            new MainText("Класс"),
            classList,
            new MainText("Формат занятий"),
            new CheckBoxesFormatLessonsForStudent(
                formatLessonsChanged, _formatLessons),
            new MainText("Пол"),
            new SecondSex(sexChanged, _sex),
            new MainText("Номер телефона"),
            new TextFieldWidget(false, phoneChanged, _phone),
            new MainText("Новый пароль"),
            new TextFieldWidget(true, passwordChanged),
            new MainText("Email"),
            new TextFieldWidget(false, emailChanged, _email),
            new MainText("Изучаемые предметы"),
            new CheckBoxesLessons(lessonsChanged, _lessons),
            new MainText("О себе"),
            new TextareaRasp(aboutChanged, _about),
            new ButtonWidget("Сменить фото", _clickChoosePhotoButton),
            new Container(
              height: 10,
            ),
            new ButtonWidget("Сохранить", clickRegisterButton),
            new Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
