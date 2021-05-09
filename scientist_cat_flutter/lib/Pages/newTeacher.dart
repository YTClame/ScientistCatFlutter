import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesFormatLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesViewLessons.dart';
import 'package:scientist_cat_flutter/Widgets/droppedList.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:scientist_cat_flutter/Widgets/secondSex.dart';
import 'package:scientist_cat_flutter/Widgets/textField.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
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
String _login = "";
String _password = "";
String _email = "";
List<String> _lessons = [];
String _price = "";
List<String> _viewsLessons = [];

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

void loginChanged(BuildContext context, String text) {
  _login = text;
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

void clickRegisterButton(BuildContext context) {
  String stotRes = "0", ttosRes = "0", distantRes = "0";
  for (String s in _formatLessons) {
    if (s == "Я к ученику") ttosRes = "1";
    if (s == "Ученик ко мне") stotRes = "1";
    if (s == "Дистанционно") distantRes = "1";
  }
  String sexRes = "m";
  if (_sex == "Женский") sexRes = "w";
  String mathRes = "0",
      rusRes = "0",
      phisRes = "0",
      infRes = "0",
      chemRes = "0",
      bioRes = "0",
      histRes = "0",
      socRes = "0",
      litRes = "0",
      geoRes = "0",
      ecoRes = "0",
      engRes = "0",
      nemRes = "0",
      soloRes = "0",
      groupRes = "0",
      homeRes = "0",
      standartRes = "0";
  for (String s in _lessons) {
    if (s == "Математика") mathRes = "1";
    if (s == "Русский язык") rusRes = "1";
    if (s == "Физика") phisRes = "1";
    if (s == "Информатика") infRes = "1";
    if (s == "Химия") chemRes = "1";
    if (s == "Биология") bioRes = "1";
    if (s == "История") histRes = "1";
    if (s == "Обществознание") socRes = "1";
    if (s == "Литература") litRes = "1";
    if (s == "География") geoRes = "1";
    if (s == "Экономика") ecoRes = "1";
    if (s == "Английский язык") engRes = "1";
    if (s == "Немецкий язык") nemRes = "1";
  }

  for (String s in _viewsLessons) {
    if (s == "Разовые") soloRes = "1";
    if (s == "Групповые") groupRes = "1";
    if (s == "Помощь с домашней работой") homeRes = "1";
    if (s == "Обычные") standartRes = "1";
  }

  API
      .newTeacher(
          _city,
          _secondName,
          _firstName,
          _birthday,
          stotRes,
          ttosRes,
          distantRes,
          _education,
          _stash,
          sexRes,
          _phone,
          _login,
          _password,
          _email,
          mathRes,
          rusRes,
          phisRes,
          infRes,
          chemRes,
          bioRes,
          histRes,
          socRes,
          litRes,
          geoRes,
          ecoRes,
          engRes,
          nemRes,
          _price,
          soloRes,
          groupRes,
          homeRes,
          standartRes)
      .then((res) {
    if (res[0] == "Error") {
      if (res[1] == "Bad Login")
        Toast.show("Логин некорректный или уже занят", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      else if (res[1] == "Bad Phone")
        Toast.show("Номер телефона некорректный или уже занят", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      else if (res[1] == "Bad Email")
        Toast.show("Email некорректный или уже занят", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      else
        Toast.show(res[1], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      Settings().setToken(res[1]);
      Settings().setRole("Репетитор");
      API
          .getInfoAboutUserForToken(res[1], "Репетитор")
          .then((value) => {_loadLK(context, value)});
    }
  });
}

void _loadLK(BuildContext context, Map<String, dynamic> info) {
  Settings().setUserInfo(info);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
              LkAdapter(TypePage.LkTeacher)),
      (Route<dynamic> route) => false);
}

class NewTeacherWidget extends StatelessWidget {
  List<String> _cities;
  DroppedList citiesList = new DroppedList([], "Загрузка", cityChanged);
  DroppedList educationList = new DroppedList(
      ['Студент', 'Аспирант', 'Учитель', 'Преподаватель'],
      "Студент",
      educationChanged);

  NewTeacherWidget() {
    API.getCities().then((cities) {
      this._cities = cities;
      citiesList.updateList(this._cities[0], cities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      body: new SingleChildScrollView(
        child: new Center(
          child: new Column(
            children: [
              new Container(
                height: 35.0,
              ),
              new Container(
                child: new Text(
                  "Регистрация репетитора",
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
              new TextFieldWidget(false, textChangedSecondName),
              new MainText("Имя"),
              new TextFieldWidget(false, textChangedFirstName),
              new MainText("Дата рождения"),
              new TextFieldWidget(false, textChangedBirthday),
              new MainText("Формат занятий"),
              new CheckBoxesFormatLessons(formatLessonsChanged),
              new MainText("Образование"),
              educationList,
              new MainText("Стаж преподавания в полных годах"),
              new TextFieldWidget(false, stashChanged),
              new MainText("Пол"),
              new SecondSex(sexChanged),
              new MainText("Номер телефона"),
              new TextFieldWidget(false, phoneChanged),
              new MainText("Логин"),
              new TextFieldWidget(false, loginChanged),
              new MainText("Пароль"),
              new TextFieldWidget(true, passwordChanged),
              new MainText("Email"),
              new TextFieldWidget(false, emailChanged),
              new MainText("Преподаваемые предметы"),
              new CheckBoxesLessons(lessonsChanged),
              new MainText("Ставка в час (целое число)"),
              new TextFieldWidget(false, priceChanged),
              new MainText("Вид занятий"),
              new CheckBoxesViewLessons(viewsLessonsChanged),
              new ButtonWidget("Зарегистрироваться", clickRegisterButton),
              new Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(198, 224, 255, 1.0),
    ));
  }
}
