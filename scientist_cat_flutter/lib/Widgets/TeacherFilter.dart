import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesEducation.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesLessons.dart';
import 'package:scientist_cat_flutter/Widgets/textField.dart';
import 'package:scientist_cat_flutter/Widgets/thritySex.dart';

import '../Settings.dart';
import 'checkboxesFormatLessonsForStudent.dart';
import 'mainText.dart';

class TeacherFilter extends StatefulWidget {
  Function _callback;

  TeacherFilter(this._callback) {
    _sss = new _TeacherFilterState(_callback);
  }

  _TeacherFilterState _sss;

  @override
  createState() => _sss;
}

class _TeacherFilterState extends State<TeacherFilter> {
  Function _callback;

  List<String> _formatLessons = [];
  String _minStash = "";
  String _maxStash = "";
  String _sex = "";
  List<String> _lessons = [];
  String _minPrice = "";
  String _maxPrice = "";
  List<String> _education = [];

  bool _isHidden;

  _TeacherFilterState(this._callback) {
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

  void _minStashUpdate(BuildContext context, String text) {
    this._minStash = text;
  }

  void _maxStashUpdate(BuildContext context, String text) {
    this._maxStash = text;
  }

  void _sexUpdate(BuildContext context, String sex) {
    this._sex = sex;
  }

  void _lessonsUpdate(BuildContext context, List<String> lessons) {
    this._lessons = lessons;
  }

  void _minPriceUpdate(BuildContext context, String text) {
    this._minPrice = text;
  }

  void _maxPriceUpdate(BuildContext context, String text) {
    this._maxPrice = text;
  }

  void _educationUpdate(BuildContext context, List<String> education) {
    this._education = education;
  }

  void setFilter(BuildContext context) {
    Map<String, dynamic> res = new Map();
    res['stot'] = _formatLessons.contains("Я к репетитору") ? "1" : "0";
    res['ttos'] = _formatLessons.contains("Репетитор ко мне") ? "1" : "0";
    res['dist'] = _formatLessons.contains("Дистанционно") ? "1" : "0";
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
    res['minS'] = _minStash;
    res['maxS'] = _maxStash;
    res['minP'] = _minPrice;
    res['maxP'] = _maxPrice;
    res['edS'] = _education.contains("Студент") ? "1" : "0";
    res['edA'] = _education.contains("Аспирант") ? "1" : "0";
    res['edT'] = _education.contains("Учитель") ? "1" : "0";
    res['edP'] = _education.contains("Преподаватель") ? "1" : "0";
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
            new CheckBoxesFormatLessonsForStudent(_formatLessonsUpdate, _formatLessons),
            new MainText("Минимальный стаж"),
            new TextFieldWidget(false, _minStashUpdate, _minStash),
            new MainText("Максимальный стаж"),
            new TextFieldWidget(false, _maxStashUpdate, _maxStash),
            new MainText("Пол"),
            new ThritySex(_sexUpdate, _sex),
            new MainText("Предметы"),
            new CheckBoxesLessons(_lessonsUpdate, _lessons),
            new MainText("Минимальная ставка"),
            new TextFieldWidget(false, _minPriceUpdate, _minPrice),
            new MainText("Максимальная ставка"),
            new TextFieldWidget(false, _maxPriceUpdate, _maxPrice),
            new MainText("Образование"),
            new CheckBoxesEducation(_educationUpdate, _education),
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
