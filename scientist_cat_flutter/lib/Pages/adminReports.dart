import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/ResultStudent.dart';
import 'package:scientist_cat_flutter/Widgets/ResultTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/StudentFilter.dart';
import 'package:scientist_cat_flutter/Widgets/TeacherFilter.dart';
import 'package:scientist_cat_flutter/Widgets/adminOneReport.dart';

import '../APIs.dart';
import '../Settings.dart';

class AdminReports extends StatefulWidget {
  AdminReports(Function _callback, Function _callbackMes) {
    _sss = new _AdminReportsState(_callback, _callbackMes);
  }

  _AdminReportsState _sss;

  @override
  createState() => _sss;
}

class _AdminReportsState extends State<AdminReports> {
  Function _callback;
  Function _callbackMes;
  List<Map<String, dynamic>> _reports;

  _AdminReportsState(this._callback, this._callbackMes) {
    _reports = [];
  }

  @override
  void initState() {
    super.initState();
    API.getReports(Settings().getToken()).then((value) => _loadReports(value));
  }

  void _loadReports(List<Map<String, dynamic>> reports) {
    this._reports = reports;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: _reports
              .map<Widget>((oneReport) => new AdminOneReport(
                  oneReport, _callback, _callbackMes, _removeReport))
              .toList(),
        ),
      ),
      constraints: BoxConstraints.expand(),
    );
  }

  void _removeReport(BuildContext context, Map<String, dynamic> report) {
    _reports.remove(report);
    setState(() {});
  }
}
