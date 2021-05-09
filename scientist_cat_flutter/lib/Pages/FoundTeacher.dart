import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/ResultTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/TeacherFilter.dart';

import '../APIs.dart';

class FoundTeacher extends StatefulWidget {
  FoundTeacher(Function _callback) {
    _sss = new _FoundTeacherState(_callback);
  }

  _FoundTeacherState _sss;

  @override
  createState() => _sss;
}

class _FoundTeacherState extends State<FoundTeacher> {
  List<Map<String, dynamic>> _teachers;
  Function _callback;

  _FoundTeacherState(this._callback) {
    _teachers = [];
  }

  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new TeacherFilter(useNewFilter),
            new Column(
              children: _teachers
                  .map<Widget>((teacher) => new ResultTeacher(
                      teacher['Фамилия'],
                      teacher['Имя'],
                      teacher['Образование'],
                      teacher['Стаж'].toString(),
                      teacher['Ставка'].toString(),
                      teacher['Фото'],
                      teacher['ID'].toString(),
                      _callback))
                  .toList(),
            ),
          ],
        ),
        //color: Color.fromRGBO(198, 224, 255, 1.0),
      ),
      constraints: BoxConstraints.expand(),
    );
  }

  void useNewFilter(BuildContext context, Map<String, dynamic> filter) {
    API.foundTeacher(filter).then((value) => printResults(value));
  }

  void printResults(List<Map<String, dynamic>> res) {
    _teachers = res;
    setState(() {});
  }
}
