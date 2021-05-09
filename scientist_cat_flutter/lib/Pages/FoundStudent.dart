import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/ResultStudent.dart';
import 'package:scientist_cat_flutter/Widgets/ResultTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/StudentFilter.dart';
import 'package:scientist_cat_flutter/Widgets/TeacherFilter.dart';

import '../APIs.dart';

class FoundStudent extends StatefulWidget {
  FoundStudent(Function _callback) {
    _sss = new _FoundStudentState(_callback);
  }

  _FoundStudentState _sss;

  @override
  createState() => _sss;
}

class _FoundStudentState extends State<FoundStudent> {
  List<Map<String, dynamic>> _students;
  Function _callback;

  _FoundStudentState(this._callback) {
    _students = [];
  }

  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new StudentFilter(useNewFilter),
            new Column(
              children: _students
                  .map<Widget>((student) => new ResultStudent(
                      student['Фамилия'],
                      student['Имя'],
                      student['Класс'].toString(),
                      student['Фото'],
                      student['ID'].toString(),
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
    API.foundStudent(filter).then((value) => printResults(value));
  }

  void printResults(List<Map<String, dynamic>> res) {
    _students = res;
    setState(() {});
  }
}
