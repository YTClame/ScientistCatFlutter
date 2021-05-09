import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';
import 'package:scientist_cat_flutter/Pages/lkAdapter.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';

import 'APIs.dart';
import 'Settings.dart';

enum _ErrorType { BadInternet, BadServer, Good }

_ErrorType _er;

void main() async {
  _er = _ErrorType.Good;
  await GetStorage.init();
  API.getHost().catchError((e) {
    _er = _ErrorType.BadInternet;
    runApp(
      new MaterialApp(
        home: new Scaffold(
            body: new Center(
          child: new Text(
            "Проверьте подключение к интернету",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: 'InputFont',
              fontSize: 25,
              height: 1.1,
              color: Color.fromRGBO(0, 117, 255, 1.0),
            ),
          ),
        )),
      ),
    );
  }).then((value) => {_tryLogin(value)});
}

void _tryLogin(String host) {
  if (_er == _ErrorType.BadInternet) return;
  Widget errorWidget = new MaterialApp(
    home: new Scaffold(
        body: new Center(
      child: new Text(
        "К сожалению, сервер не отвечает",
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontFamily: 'InputFont',
          fontSize: 25,
          height: 1.1,
          color: Color.fromRGBO(0, 117, 255, 1.0),
        ),
      ),
    )),
  );
  Settings().setHost(host);
  String token = Settings().getToken();
  if (token == "") {
    API.getCities().catchError((e) {
      _er = _ErrorType.BadServer;
      runApp(errorWidget);
    }).then((value) => {_loadAuth(value)});
  } else {
    if (Settings().getRole() == "Репетитор") {
      API.getInfoAboutUserForToken(token, "Репетитор").catchError((e) {
        _er = _ErrorType.BadServer;
        runApp(errorWidget);
      }).then(
          (value) => {_setInfoAboutUserAndOpenLK(value, token, "Репетитор")});
    }
    if (Settings().getRole() == "Ученик") {
      API.getInfoAboutUserForToken(token, "Ученик").catchError((e) {
        _er = _ErrorType.BadServer;
        runApp(errorWidget);
      }).then((value) => {_setInfoAboutUserAndOpenLK(value, token, "Ученик")});
    }
  }
}

void _loadAuth(List<String> cities) {
  if(_er == _ErrorType.BadServer) return;
  Settings().setCities(cities);
  runApp(new AuthWidget());
}

void _setInfoAboutUserAndOpenLK(
    Map<String, dynamic> info, String token, String role) {
  if (_er == _ErrorType.BadServer) return;
  if (info['Статус'] == "Error") {
    Settings().setToken("");
    Settings().setRole("");
    runApp(new AuthWidget());
  } else {
    Settings().setUserInfo(info);
    log('Токен: ' + Settings().getToken());
    log('Роль: ' + Settings().getRole());
    log('email: ' + Settings().getUserInfo()['Email']);
    if (role == "Репетитор") {
      runApp(new LkAdapter(TypePage.LkTeacher));
    } else if (role == "Ученик") {
      runApp(new LkAdapter(TypePage.LkStudent));
    }
  }
}
