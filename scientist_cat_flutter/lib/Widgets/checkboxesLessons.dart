import 'package:flutter/material.dart';

class CheckBoxesLessons extends StatefulWidget {
  Function _callback;

  CheckBoxesLessons(this._callback, [List<String> values]) {
    if(values == null)
      _sss = new _CheckBoxesLessonsState(_callback);
    else
      _sss = new _CheckBoxesLessonsState(_callback, values);
  }

  _CheckBoxesLessonsState _sss;

  @override
  createState() => _sss;
}

class _CheckBoxesLessonsState extends State<CheckBoxesLessons> {
  Function _callback;
  bool _math = false;
  bool _rus = false;
  bool _phis = false;
  bool _inf = false;
  bool _chem = false;
  bool _bio = false;
  bool _hist = false;
  bool _soc = false;
  bool _lit = false;
  bool _geo = false;
  bool _eco = false;
  bool _eng = false;
  bool _nem = false;

  _CheckBoxesLessonsState(this._callback, [List<String> values]){
    if (values != null){
      _math = values.contains("Математика") ? true : false;
      _rus = values.contains("Русский язык") ? true : false;
      _phis = values.contains("Физика") ? true : false;
      _inf = values.contains("Информатика") ? true : false;
      _chem = values.contains("Химия") ? true : false;
      _bio = values.contains("Биология") ? true : false;
      _hist = values.contains("История") ? true : false;
      _soc = values.contains("Обществознание") ? true : false;
      _lit = values.contains("Литература") ? true : false;
      _geo = values.contains("География") ? true : false;
      _eco = values.contains("Экономика") ? true : false;
      _eng = values.contains("Английский язык") ? true : false;
      _nem = values.contains("Немецкий язык") ? true : false;
    }
  }

  Widget build(BuildContext context) {
    List<String> lessons = [];
    if (_math) lessons.add("Математика");
    if (_rus) lessons.add("Русский язык");
    if (_phis) lessons.add("Физика");
    if (_inf) lessons.add("Информатика");
    if (_chem) lessons.add("Химия");
    if (_bio) lessons.add("Биология");
    if (_hist) lessons.add("История");
    if (_soc) lessons.add("Обществознание");
    if (_lit) lessons.add("Литература");
    if (_geo) lessons.add("География");
    if (_eco) lessons.add("Экономика");
    if (_eng) lessons.add("Английский язык");
    if (_nem) lessons.add("Немецкий язык");

    _callback(context, lessons);
    return new Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              "Математика",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _math,
            onChanged: (newValue) {
              setState(() {
                _math = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Русский язык",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _rus,
            onChanged: (newValue) {
              setState(() {
                _rus = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Физика",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _phis,
            onChanged: (newValue) {
              setState(() {
                _phis = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Информатика",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _inf,
            onChanged: (newValue) {
              setState(() {
                _inf = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Химия",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _chem,
            onChanged: (newValue) {
              setState(() {
                _chem = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Биология",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _bio,
            onChanged: (newValue) {
              setState(() {
                _bio = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "История",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _hist,
            onChanged: (newValue) {
              setState(() {
                _hist = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Обществознание",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _soc,
            onChanged: (newValue) {
              setState(() {
                _soc = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Литература",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _lit,
            onChanged: (newValue) {
              setState(() {
                _lit = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "География",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _geo,
            onChanged: (newValue) {
              setState(() {
                _geo = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Экономика",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _eco,
            onChanged: (newValue) {
              setState(() {
                _eco = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Английский язык",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _eng,
            onChanged: (newValue) {
              setState(() {
                _eng = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text(
              "Немецкий язык",
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            value: _nem,
            onChanged: (newValue) {
              setState(() {
                _nem = newValue;
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
