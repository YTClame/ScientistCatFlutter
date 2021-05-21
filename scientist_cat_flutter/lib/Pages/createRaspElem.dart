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
String _date = "";

void textChangedDate(BuildContext context, String text) {
  _date = text;
}

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
  if(_date.trim().length == 0 ||_timeStart.trim().length == 0||_timeEnd.trim().length == 0||_task.trim().length == 0){
    Toast.show("Заполните все поля в удобном для вас формате!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    return;
  }
  API.createRaspElem(Settings().getToken(), _date, _timeStart, _timeEnd, _task).then((value) => _continueCreating(context, value));
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

class CreateRaspElem extends StatelessWidget {
  Function _callback;
  CreateRaspElem(this._callback){
    callback = _callback;
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new MainText("Дата"),
            new TextFieldWidget(false, textChangedDate),
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
