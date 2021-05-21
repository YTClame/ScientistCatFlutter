import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/additionalRasp.dart';
import 'package:scientist_cat_flutter/Widgets/mainTextCenter.dart';
import 'package:scientist_cat_flutter/Widgets/oneDayRasp.dart';
import 'package:scientist_cat_flutter/Widgets/raspAddButton.dart';

import '../APIs.dart';
import '../Settings.dart';

class Rasp extends StatefulWidget {
  Rasp(Function _lkAdapterCallback, Function _createCallback, Function _editCallback) {
    _rs = new _RaspState(_lkAdapterCallback, _createCallback, _editCallback);
  }

  _RaspState _rs;

  @override
  createState() => _rs;
}

class _RaspState extends State<Rasp> {
  Function _lkAdapterCallback;
  Function _createCallback;
  Function _editCallback;
  _RaspState(this._lkAdapterCallback, this._createCallback, this._editCallback);

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
        .getRaspForToken(Settings().getToken())
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
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            MainTextCenter("Расписание по дням недели:"),
            new OneDayRasp("Понедельник", _monday, addRaspElem, updateRasp, _editCallback),
            new OneDayRasp("Вторник", _tuesday, addRaspElem, updateRasp, _editCallback),
            new OneDayRasp("Среда", _wednesday, addRaspElem, updateRasp, _editCallback),
            new OneDayRasp("Четверг", _thursday, addRaspElem, updateRasp, _editCallback),
            new OneDayRasp("Пятница", _friday, addRaspElem, updateRasp, _editCallback),
            new OneDayRasp("Суббота", _saturday, addRaspElem, updateRasp, _editCallback),
            new OneDayRasp("Воскресенье", _sunday, addRaspElem, updateRasp, _editCallback),
            new Container(height: 20,),
            MainTextCenter("Дополнительное расписание по датам:"),
            new AdditionalRasp(_anotherDayParsed, addRaspElem, updateRasp, _editCallback),
            new Container(height: 10,),
            new RaspAddButton("Создать", createRaspElem, "NULL"),
          ],
        ),
      ),
      constraints: BoxConstraints.expand(),
    );
  }

  void addRaspElem(BuildContext context, String dayName){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['Дата'] = dayName;
    map['UpdateF'] = updateRasp;
    _lkAdapterCallback(context, map);
  }

  void createRaspElem(BuildContext context, String _trash){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['UpdateF'] = updateRasp;
    _createCallback(context, map);
  }
}
