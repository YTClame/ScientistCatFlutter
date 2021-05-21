import 'package:flutter/material.dart';

class CheckBoxesEducation extends StatefulWidget {
  Function _callback;

  CheckBoxesEducation(this._callback, [List<String> values]) {
    if(values == null)
      _sss = new _CheckBoxesEducationState(_callback);
    else
      _sss = new _CheckBoxesEducationState(_callback, values);
  }

  _CheckBoxesEducationState _sss;

  @override
  createState() => _sss;
}

class _CheckBoxesEducationState extends State<CheckBoxesEducation> {
  Function _callback;
  bool _student = false;
  bool _aspir = false;
  bool _teacher = false;
  bool _prepod = false;

  _CheckBoxesEducationState(this._callback, [List<String> values]){
    if(values != null){
      _student = values.contains("Студент") ? true : false;
      _aspir = values.contains("Аспирант") ? true : false;
      _teacher = values.contains("Учитель") ? true : false;
      _prepod = values.contains("Преподаватель") ? true : false;
    }
  }

  Widget build(BuildContext context) {
    List<String> views = [];
    if (_student) views.add("Студент");
    if (_aspir) views.add("Аспирант");
    if (_teacher) views.add("Учитель");
    if (_prepod) views.add("Преподаватель");
    _callback(context, views);
    return new Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              "Студент",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _student,
            onChanged: (newValue) {
              setState(() {
                _student = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Аспирант",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _aspir,
            onChanged: (newValue) {
              setState(() {
                _aspir = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Учитель",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _teacher,
            onChanged: (newValue) {
              setState(() {
                _teacher = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Преподаватель",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _prepod,
            onChanged: (newValue) {
              setState(() {
                _prepod = newValue;
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
