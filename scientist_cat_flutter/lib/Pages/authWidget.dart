import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scientist_cat_flutter/Pages/lkAdapter.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:scientist_cat_flutter/Widgets/textField.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'newStudent.dart';
import 'newTeacher.dart';

//Каллбеки на кнопки:
void clickEnterButton(BuildContext context) {
  API.login(login, password).then((value) => {handlerLoginRes(value, context)});
}

void handlerLoginRes(Map<String, dynamic> map, BuildContext context) {
  String token;
  String role;
  if (map['Токен'] != 'Error') {
    token = map['Токен'];
    role = map['Роль'];
    if (role == "Репетитор") {
      API.getInfoAboutUserForToken(token, role).then(
          (value) => {_setInfoAboutUserAndOpenLK(context, value, token, role)});
    }
    if (role == "Ученик") {
      API.getInfoAboutUserForToken(token, role).then(
          (value) => {_setInfoAboutUserAndOpenLK(context, value, token, role)});
    }
  } else {
    Toast.show("Ошибка авторизации!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}

void _setInfoAboutUserAndOpenLK(BuildContext context, Map<String, dynamic> info,
    String token, String role) {
  if (info['Статус'] == "Error") {
    Toast.show("Ошибка авторизации!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  } else {
    Settings().setToken(token);
    Settings().setRole(role);
    Settings().setUserInfo(info);
    if (role == "Репетитор") {
      API.updateOnline();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LkAdapter(TypePage.LkTeacher)),
          (Route<dynamic> route) => false);
    } else if (role == "Ученик") {
      API.updateOnline();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LkAdapter(TypePage.LkStudent)),
          (Route<dynamic> route) => false);
    }
  }
}

void clickNewTeacherButton(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => new NewTeacherWidget()));
}

void clickNewStudentButton(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => new NewStudentWidget()));
}

//Каллбеки на поля ввода:
void textChangedLogin(BuildContext context, String text) {
  login = text;
}

void textChangedPassword(BuildContext context, String text) {
  password = text;
}

String login = "";
String password = "";

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      body: SingleChildScrollView(
        child: new Center(
            child: new Column(
          children: [
            new Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: new Container(
                  child: Image.asset('images/logo.png'),
                  width: 200,
                  height: 200,
                )),
            new MainText("Логин"),
            new TextFieldWidget(false, textChangedLogin),
            new MainText("Пароль"),
            new TextFieldWidget(true, textChangedPassword),
            new ButtonWidget("Войти", clickEnterButton),
            new Container(
              height: 30,
            ),
            new ButtonWidget("Регистрация ученику", clickNewStudentButton),
            new Container(
              height: 5,
            ),
            new ButtonWidget("Регистрация репетитору", clickNewTeacherButton),
          ],
        )),
      ),
      backgroundColor: Color.fromRGBO(198, 224, 255, 1.0),
    ));
  }
}
