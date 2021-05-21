import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';

import '../Settings.dart';

class AdminDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset("images/adminava.png", height: 100,),
              ),
              Container(
                height: 7,
              ),
              Text(
                "Администратор",
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
            title: Text('Жалобы',
                style: TextStyle(fontSize: 23.0, fontFamily: "MainFont")),
            onTap: () {
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
