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
  API.createRaspElem(Settings().getToken(), _thisDate, _timeStart, _timeEnd, _task).then((value) => _continueCreating(context, value));
}

Function callback;

void _continueCreating(BuildContext context, String res){
  if(res == "Error")
    Toast.show("Ошибка добавления!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  else{
    Navigator.pop(context);
    callback();
  }
}

class AddRaspElem extends StatelessWidget {
  Function _callback;
  String _date;
  AddRaspElem(this._callback, this._date){
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
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new MainText("Время начала"),
            new TextFieldWidget(false, textChangedTimeStart),
            new MainText("Время окончания"),
            new TextFieldWidget(false, textChangedTimeEnd),
            new MainText("Занятие"),
            new TextareaRasp(textChangedTask),
            new ButtonWidget("Сохранить", clickAddButton),
          ],
        ),
      ),
      constraints: BoxConstraints.expand(),
    );
  }
}
