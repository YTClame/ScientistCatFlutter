import 'package:flutter/material.dart';

class CheckBoxesViewLessons extends StatefulWidget {
  Function _callback;

  CheckBoxesViewLessons(this._callback) {
    _sss = new _CheckBoxesViewLessonsState(_callback);
  }

  _CheckBoxesViewLessonsState _sss;

  @override
  createState() => _sss;
}

class _CheckBoxesViewLessonsState extends State<CheckBoxesViewLessons> {
  Function _callback;
  bool _single = false;
  bool _group = false;
  bool _homework = false;
  bool _standart = false;

  _CheckBoxesViewLessonsState(this._callback);

  Widget build(BuildContext context) {
    List<String> views = [];
    if (_single) views.add("Разовые");
    if (_group) views.add("Групповые");
    if (_homework) views.add("Помощь с домашней работой");
    if (_standart) views.add("Обычные");
    _callback(context, views);
    return new Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              "Разовые",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _single,
            onChanged: (newValue) {
              setState(() {
                _single = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Групповые",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _group,
            onChanged: (newValue) {
              setState(() {
                _group = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Помощь с домашней работой",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _homework,
            onChanged: (newValue) {
              setState(() {
                _homework = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Обычные",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _standart,
            onChanged: (newValue) {
              setState(() {
                _standart = newValue;
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
