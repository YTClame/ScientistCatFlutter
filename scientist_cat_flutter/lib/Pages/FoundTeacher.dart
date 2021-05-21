import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/ResultTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/TeacherFilter.dart';

import '../APIs.dart';
import '../Settings.dart';

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
    _loadStandartFilter();
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

  void _loadStandartFilter(){
    Map<String, dynamic> res = new Map();
    res['stot'] = "0";
    res['ttos'] = "0";
    res['dist'] = "0";
    res['sex'] = "a";
    res['math'] = "0";
    res['rus'] = "0";
    res['phis'] = "0";
    res['inf'] = "0";
    res['chem'] = "0";
    res['bio'] = "0";
    res['hist'] = "0";
    res['soc'] = "0";
    res['lit'] = "0";
    res['geo'] = "0";
    res['eco'] = "0";
    res['eng'] = "0";
    res['nem'] = "0";
    res['minS'] = "";
    res['maxS'] = "";
    res['minP'] = "";
    res['maxP'] = "";
    res['edS'] = "0";
    res['edA'] = "0";
    res['edT'] = "0";
    res['edP'] = "0";
    res['token'] = Settings().getToken();
    useNewFilter(res);
  }

  void useNewFilter(Map<String, dynamic> filter) {
    API.foundTeacher(filter).then((value) => printResults(value));
  }

  void printResults(List<Map<String, dynamic>> res) {
    _teachers = res;
    setState(() {});
  }
}
