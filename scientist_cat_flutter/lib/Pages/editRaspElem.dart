import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Pages/newTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesFormatLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesFormatLessonsForStudent.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesLessons.dart';
import 'package:scientist_cat_flutter/Widgets/checkboxesViewLessons.dart';
import 'package:scientist_cat_flutter/Widgets/droppedList.dart';
import 'package:scientist_cat_flutter/Widgets/mainText.dart';
import 'package:scientist_cat_flutter/Widgets/secondSex.dart';
import 'package:scientist_cat_flutter/Widgets/textField.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:scientist_cat_flutter/Widgets/textareaRasp.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'lkAdapter.dart';

//Каллбеки:
String _timeStartOld = "";
String _timeEndOld = "";
String _taskOld = "";

String _timeStart = "";
String _timeEnd = "";
String _task = "";
String _thisDate = "";

void textChangedTimeStart(BuildContext context, String text) {
  _timeStart = text;
}

void textChangedTimeEnd(BuildContext context, String text) {
  _timeEnd = text;
}

void textChangedTask(BuildContext context, String text) {
  _task = text;
}

void clickAddButton(BuildContext context) {
  if(_task == _taskOld && _timeStart == _timeStartOld && _timeEnd == _timeEndOld){
    Navigator.pop(context);
    return;
  }
  API.editRaspElem(Settings().getToken(), _thisDate, _timeStartOld, _timeEndOld, _taskOld, _timeStart, _timeEnd, _task).then((value) => _continueEdit(context, value));
}

Function callback;

void _continueEdit(BuildContext context, String res){
  if(res == "Error")
    Toast.show("Ошибка редактирования!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  else{
    Navigator.pop(context);
    callback();
  }
}

class EditRaspElem extends StatelessWidget {
  Function _callback;
  String _date;
  String _time1;
  String _time2;
  String _taskLocal;
  EditRaspElem(this._callback, this._date, this._time1, this._time2, this._taskLocal){
    callback = _callback;
    if(_date == "Понедельник")
      _thisDate = "Пн";
    else if(_date == "Вторник")
      _thisDate = "Вт";
    else if(_date == "Среда")
      _thisDate = "Ср";
    else if(_date == "Четверг")
      _thisDate = "Чт";
    else if(_date == "Пятница")
      _thisDate = "Пт";
    else if(_date == "Суббота")
      _thisDate = "Сб";
    else if(_date == "Воскресенье")
      _thisDate = "Вс";
    else
      _thisDate = _date;
    _timeStart = _time1;
    _timeEnd = _time2;
    _task = _taskLocal;
    _timeStartOld = _time1;
    _timeEndOld = _time2;
    _taskOld = _taskLocal;
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new MainText("Время начала"),
            new TextFieldWidget(false, textChangedTimeStart, _timeStart),
            new MainText("Время окончания"),
            new TextFieldWidget(false, textChangedTimeEnd, _timeEnd),
            new MainText("Занятие"),
            new TextareaRasp(textChangedTask, _task),
            new ButtonWidget("Сохранить", clickAddButton),
          ],
        ),
      ),
      constraints: BoxConstraints.expand(),
    );
  }
}
