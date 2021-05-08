import 'package:flutter/material.dart';

class CheckBoxesFormatLessons extends StatefulWidget {
  Function _callback;

  CheckBoxesFormatLessons(this._callback) {
    _sss = new _CheckBoxesFormatLessonsState(_callback);
  }

  _CheckBoxesFormatLessonsState _sss;

  @override
  createState() => _sss;
}

class _CheckBoxesFormatLessonsState extends State<CheckBoxesFormatLessons> {
  Function _callback;
  bool _ttos = false;
  bool _stot = false;
  bool _distant = false;

  _CheckBoxesFormatLessonsState(this._callback);

  Widget build(BuildContext context) {
    List<String> formats = [];
    if (_ttos) formats.add("Я к ученику");
    if (_stot) formats.add("Ученик ко мне");
    if (_distant) formats.add("Дистанционно");
    _callback(context, formats);
    return new Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              "Я к ученику",
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
              "Ученик ко мне",
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
