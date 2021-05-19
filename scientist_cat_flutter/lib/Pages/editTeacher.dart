import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesFormatLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesViewLessons.dart';
import 'package:scientist_cat_flutter/Widgets/droppedList.dart';
import 'package:scientist_cat_flutter/Widgets/droppedList.dart';
import 'package:scientist_cat_flutter/Widgets/droppedList.dart';
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
String _sex = "";
List<String> _formatLessons = [];
String _education = "";
String _stash = "";
String _phone = "";
String _password = "";
String _email = "";
List<String> _lessons = [];
String _price = "";
List<String> _viewsLessons = [];
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

void sexChanged(BuildContext context, String text) {
  _sex = text;
}

void formatLessonsChanged(BuildContext context, List<String> formats) {
  _formatLessons = formats;
}

void educationChanged(BuildContext context, String text) {
  _education = text;
}

void stashChanged(BuildContext context, String text) {
  _stash = text;
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

void priceChanged(BuildContext context, String text) {
  _price = text;
}

void viewsLessonsChanged(BuildContext context, List<String> views) {
  _viewsLessons = views;
}

void aboutChanged(BuildContext context, String text) {
  _about = text;
}

void clickRegisterButton(BuildContext context) {
  API
      .editTeacher(
          _image,
          _city,
          _secondName,
          _firstName,
          _birthday,
          _formatLessons,
          _education,
          _stash,
          _sex,
          _phone,
          _password,
          _email,
          _lessons,
          _price,
          _viewsLessons,
          _about)
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

class EditTeacher extends StatelessWidget {
  Map<String, dynamic> _userInfo;
  DroppedList citiesList;
  DroppedList educationList;

  EditTeacher(Function openChoosePhotoCallback, Function openLkCallback) {
    _openLkCallback = openLkCallback;
    _openChoosePhotoCallback = openChoosePhotoCallback;
    _userInfo = Settings().getUserInfo();
    citiesList = new DroppedList(
        Settings().getCities(), _userInfo['Город'], cityChanged);
    educationList = new DroppedList(
        ['Студент', 'Аспирант', 'Учитель', 'Преподаватель'],
        _userInfo['Образование'].toString(),
        educationChanged);
    _city = _userInfo['Город'];
    _secondName = _userInfo['Фамилия'];
    _firstName = _userInfo['Имя'];
    _birthday = _userInfo['Дата рождения'];
    _stash = _userInfo['Стаж'].toString();
    _phone = _userInfo['Телефон'];
    _email = _userInfo['Email'];
    _price = _userInfo["Ставка"].toString();
    _about = _userInfo['О себе'];
    _formatLessons = new List<String>.from(_userInfo['Формат занятий']);
    _lessons = new List<String>.from(_userInfo['Преподаваемые предметы']);
    _viewsLessons = new List<String>.from(_userInfo['Вид занятий']);
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
            new MainText("Формат занятий"),
            new CheckBoxesFormatLessons(formatLessonsChanged, _formatLessons),
            new MainText("Образование"),
            educationList,
            new MainText("Стаж преподавания в полных годах"),
            new TextFieldWidget(false, stashChanged, _stash),
            new MainText("Пол"),
            new SecondSex(sexChanged, _sex),
            new MainText("Номер телефона"),
            new TextFieldWidget(false, phoneChanged, _phone),
            new MainText("Новый пароль"),
            new TextFieldWidget(true, passwordChanged),
            new MainText("Email"),
            new TextFieldWidget(false, emailChanged, _email),
            new MainText("Преподаваемые предметы"),
            new CheckBoxesLessons(lessonsChanged, _lessons),
            new MainText("Ставка в час (целое число)"),
            new TextFieldWidget(false, priceChanged, _price),
            new MainText("Вид занятий"),
            new CheckBoxesViewLessons(viewsLessonsChanged, _viewsLessons),
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
