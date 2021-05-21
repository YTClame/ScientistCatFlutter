import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/additionalRasp.dart';
import 'package:scientist_cat_flutter/Widgets/mainTextCenter.dart';
import 'package:scientist_cat_flutter/Widgets/oneDayRasp.dart';
import 'package:scientist_cat_flutter/Widgets/raspAddButton.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'aditionalRaspUser.dart';
import 'oneDayRaspUser.dart';

class UserRasp extends StatefulWidget {
  UserRasp() {
    _rs = new _UserRaspState();
  }

  _UserRaspState _rs;

  @override
  createState() => _rs;
}

class _UserRaspState extends State<UserRasp> {
  _UserRaspState();

  List<Map<String, dynamic>> _monday = [];
  List<Map<String, dynamic>> _tuesday = [];
  List<Map<String, dynamic>> _wednesday = [];
  List<Map<String, dynamic>> _thursday = [];
  List<Map<String, dynamic>> _friday = [];
  List<Map<String, dynamic>> _saturday = [];
  List<Map<String, dynamic>> _sunday = [];
  List<Map<String, dynamic>> _anotherDay = [];
  List<String> _printed = [];
  Map<String, dynamic> _anotherDayParsed = new Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    updateRasp();
  }

  void updateRasp(){
    API
        .getRaspForId(Settings().getTempMessengerUserId())
        .then((value) => _parseRasp(value));
  }

  void _parseRasp(List<Map<String, dynamic>> rasp) {
    _monday = [];
    _tuesday = [];
    _wednesday = [];
    _thursday = [];
    _friday = [];
    _saturday = [];
    _sunday = [];
    _anotherDay = [];
    _printed = [];
    _anotherDayParsed = new Map<String, dynamic>();
    for (Map<String, dynamic> oneRasp in rasp) {
      if (oneRasp['День'] == 'Пн')
        _monday.add(oneRasp);
      else if (oneRasp['День'] == 'Вт')
        _tuesday.add(oneRasp);
      else if (oneRasp['День'] == 'Ср')
        _wednesday.add(oneRasp);
      else if (oneRasp['День'] == 'Чт')
        _thursday.add(oneRasp);
      else if (oneRasp['День'] == 'Пт')
        _friday.add(oneRasp);
      else if (oneRasp['День'] == 'Сб')
        _saturday.add(oneRasp);
      else if (oneRasp['День'] == 'Вс')
        _sunday.add(oneRasp);
      else
        _anotherDay.add(oneRasp);
    }
    for(Map<String, dynamic> rec in _anotherDay){
      if(!_printed.contains(rec['День'])){
        _printed.add(rec['День']);
        _anotherDayParsed[rec['День']] = [];
        for(Map<String, dynamic> rec2 in _anotherDay){
          if(rec2['День'] == rec['День']){
            Map<String, dynamic> map = new Map<String, dynamic>();
            map['День'] = rec2['День'];
            map['От'] = rec2['От'];
            map['До'] = rec2['До'];
            map['Занятие'] = rec2['Занятие'];
            _anotherDayParsed[rec2['День']].add(map);
          }
        }
      }
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    if(_monday.length != 0 || _tuesday.length != 0 || _wednesday.length != 0 || _thursday.length != 0 || _friday.length != 0 || _saturday.length != 0 || _sunday.length != 0){
      if(_anotherDayParsed.isEmpty){
        return new Container(
          child: new SingleChildScrollView(
            child: new Column(
              children: [
                MainTextCenter("Расписание по дням недели:"),
                new OneDayRaspUser("Понедельник", _monday),
                new OneDayRaspUser("Вторник", _tuesday),
                new OneDayRaspUser("Среда", _wednesday),
                new OneDayRaspUser("Четверг", _thursday),
                new OneDayRaspUser("Пятница", _friday),
                new OneDayRaspUser("Суббота", _saturday),
                new OneDayRaspUser("Воскресенье", _sunday),
              ],
            ),
          ),
        );
      }
      else{
        return new Container(
          child: new SingleChildScrollView(
            child: new Column(
              children: [
                MainTextCenter("Расписание по дням недели:"),
                new OneDayRaspUser("Понедельник", _monday),
                new OneDayRaspUser("Вторник", _tuesday),
                new OneDayRaspUser("Среда", _wednesday),
                new OneDayRaspUser("Четверг", _thursday),
                new OneDayRaspUser("Пятница", _friday),
                new OneDayRaspUser("Суббота", _saturday),
                new OneDayRaspUser("Воскресенье", _sunday),
                new Container(height: 20,),
                MainTextCenter("Дополнительное расписание по датам:"),
                new AdditionalRaspUser(_anotherDayParsed),
              ],
            ),
          ),
        );
      }
    }else{
      if(_anotherDayParsed.isEmpty){
        return new Container();
      }
      else{
        return new Container(
          child: new SingleChildScrollView(
            child: new Column(
              children: [
                MainTextCenter("Дополнительное расписание по датам:"),
                new AdditionalRaspUser(_anotherDayParsed),
              ],
            ),
          ),
        );
      }
    }
  }
}
