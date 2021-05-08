import 'package:flutter/material.dart';

class CheckBoxesFormatLessonsForStudent extends StatefulWidget {
  Function _callback;

  CheckBoxesFormatLessonsForStudent(this._callback) {
    _sss = new _CheckBoxesFormatLessonsForStudentState(_callback);
  }

  _CheckBoxesFormatLessonsForStudentState _sss;

  @override
  createState() => _sss;
}

class _CheckBoxesFormatLessonsForStudentState extends State<CheckBoxesFormatLessonsForStudent> {
  Function _callback;
  bool _ttos = false;
  bool _stot = false;
  bool _distant = false;

  _CheckBoxesFormatLessonsForStudentState(this._callback);

  Widget build(BuildContext context) {
    List<String> formats = [];
    if (_stot) formats.add("Я к преподавателю");
    if (_ttos) formats.add("Преподаватель ко мне");
    if (_distant) formats.add("Дистанционно");
    _callback(context, formats);
    return new Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              "Я к преподавателю",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _stot,
            onChanged: (newValue) {
              setState(() {
                _stot = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Преподаватель ко мне",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _ttos,
            onChanged: (newValue) {
              setState(() {
                _ttos = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Дистанционно",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _distant,
            onChanged: (newValue) {
              setState(() {
                _distant = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 20.0),
    );
  }
}
