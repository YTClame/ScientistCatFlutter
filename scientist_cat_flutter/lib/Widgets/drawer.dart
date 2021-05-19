import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';

import '../Settings.dart';

class DrawerWidget extends StatelessWidget {
  final bool _isTeacher;
  String _foundButtonText;
  String _photo;

  Function _loadProfile;
  Function _loadFound;
  Function _loadContacts;
  Function _openRasp;

  DrawerWidget(this._isTeacher, this._photo, this._loadProfile,
      this._loadFound, this._loadContacts, this._openRasp) {
    if (_isTeacher)
      _foundButtonText = "Поиск ученика";
    else
      _foundButtonText = "Поиск репетитора";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _info = Settings().getUserInfo();
    String _name = _info['Фамилия'] + " " + _info['Имя'];
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: new Column(children: [
              new Container(
                decoration: BoxDecoration(
                  border: new Border.all(color: Colors.black),
                ),
                child: Image.network(
                  Settings().getHost() + _photo.substring(1) + "#" + Random().nextInt(100000).toString(),
                  height: 100,
                ),
              ),
              Container(
                height: 7,
              ),
              Text(
                _name,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "InputFont",
                    color: Colors.white),
              ),
            ]),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Личный кабинет',
                style: TextStyle(fontSize: 23.0, fontFamily: "MainFont")),
            onTap: () {
              _loadProfile(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_foundButtonText,
                style: TextStyle(fontSize: 23.0, fontFamily: "MainFont")),
            onTap: () {
              _loadFound(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Мессенджер",
                style: TextStyle(fontSize: 23.0, fontFamily: "MainFont")),
            onTap: () {
              _loadContacts(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Расписание",
                style: TextStyle(fontSize: 23.0, fontFamily: "MainFont")),
            onTap: () {
              _openRasp(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Выйти",
                style: TextStyle(fontSize: 23.0, fontFamily: "MainFont")),
            onTap: () {
              Settings().setRole("");
              Settings().setToken("");
              Settings().setUserInfo(null);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AuthWidget()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
