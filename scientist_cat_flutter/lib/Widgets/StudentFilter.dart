import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesEducation.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesLessons.dart';
import 'package:scientist_cat_flutter/Widgets/textField.dart';
import 'package:scientist_cat_flutter/Widgets/thritySex.dart';

import '../Settings.dart';
import 'checkboxesFormatLessons.dart';
import 'checkboxesFormatLessonsForStudent.dart';
import 'droppedList.dart';
import 'mainText.dart';

class StudentFilter extends StatefulWidget {
  Function _callback;

  StudentFilter(this._callback) {
    _sss = new _StudentFilterState(_callback);
  }

  _StudentFilterState _sss;

  @override
  createState() => _sss;
}

class _StudentFilterState extends State<StudentFilter> {
  Function _callback;

  List<String> _formatLessons = [];
  String _minClass = "1";
  String _maxClass = "11";
  String _sex = "";
  List<String> _lessons = [];

  bool _isHidden;

  _StudentFilterState(this._callback) {
    _isHidden = true;
  }

  void _showFilterClick(BuildContext context) {
    _isHidden = false;
    setState(() {});
  }

  void _hideFilterClick(BuildContext context) {
    _isHidden = true;
    setState(() {});
  }

  void _formatLessonsUpdate(BuildContext context, List<String> formats) {
    this._formatLessons = formats;
  }

  void _minClassUpdate(BuildContext context, String text) {
    this._minClass = text;
  }

  void _maxClassUpdate(BuildContext context, String text) {
    this._maxClass = text;
  }

  void _sexUpdate(BuildContext context, String sex) {
    this._sex = sex;
  }

  void _lessonsUpdate(BuildContext context, List<String> lessons) {
    this._lessons = lessons;
  }

  void setFilter(BuildContext context) {
    Map<String, dynamic> res = new Map();
    res['stot'] = _formatLessons.contains("Ученик ко мне") ? "1" : "0";
    res['ttos'] = _formatLessons.contains("Я к ученику") ? "1" : "0";
    res['dist'] = _formatLessons.contains("Дистанционно") ? "1" : "0";
    res['minClass'] = _minClass;
    res['maxClass'] = _maxClass;
    if (_sex == "Мужской")
      res['sex'] = "m";
    else if (_sex == "Женский")
      res['sex'] = "w";
    else if (_sex == "Любой") res['sex'] = "a";
    res['math'] = _lessons.contains("Математика") ? "1" : "0";
    res['rus'] = _lessons.contains("Русский язык") ? "1" : "0";
    res['phis'] = _lessons.contains("Физика") ? "1" : "0";
    res['inf'] = _lessons.contains("Информатика") ? "1" : "0";
    res['chem'] = _lessons.contains("Химия") ? "1" : "0";
    res['bio'] = _lessons.contains("Биология") ? "1" : "0";
    res['hist'] = _lessons.contains("История") ? "1" : "0";
    res['soc'] = _lessons.contains("Обществознание") ? "1" : "0";
    res['lit'] = _lessons.contains("Литература") ? "1" : "0";
    res['geo'] = _lessons.contains("География") ? "1" : "0";
    res['eco'] = _lessons.contains("Экономика") ? "1" : "0";
    res['eng'] = _lessons.contains("Английский язык") ? "1" : "0";
    res['nem'] = _lessons.contains("Немецкий язык") ? "1" : "0";
    res['token'] = Settings().getToken();
    _callback(res);
    _hideFilterClick(context);
  }

  Widget build(BuildContext context) {
    //_callback(context, lessons);
    if (_isHidden) {
      return Container(
          child: new Column(
            children: [
              new Container(
                height: 10,
              ),
              new ButtonWidget("Показать фильтр", _showFilterClick),
              new Container(
                height: 10,
              ),
            ],
          ));
    } else {
      return new Container(
        child: Column(
          children: [
            new Container(
              height: 10,
            ),
            new MainText("Формат занятий"),
            new CheckBoxesFormatLessons(_formatLessonsUpdate, _formatLessons),
            new MainText("Минимальный класс"),
            new DroppedList(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"], _minClass, _minClassUpdate),
            new MainText("Максимальный класс"),
            new DroppedList(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"], _maxClass, _maxClassUpdate),
            new MainText("Пол"),
            new ThritySex(_sexUpdate, _sex),
            new MainText("Предметы"),
            new CheckBoxesLessons(_lessonsUpdate, _lessons),
            new ButtonWidget("Применить", setFilter),
            new Container(height: 10),
            new ButtonWidget("Скрыть фильтр", _hideFilterClick),
            new Container(
              height: 10,
            ),
          ],
        ),
      );
    }
  }
}
