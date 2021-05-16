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
String _message = "";

void textChangedMessage(BuildContext context, String text) {
  _message = text;
}

void clickAddButton(BuildContext context) {
  API.sendReport(_data['ID'], _message).then((value) => _continueReport(context, value));
}

void _continueReport(BuildContext context, String res){
  if(res == "Error")
    Toast.show("Ошибка отправки жалобы!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  else{
    Toast.show("Жалоба успешно отправлена!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pop(context);
  }
}
Map<String, dynamic> _data;
class ReportToUser extends StatelessWidget {
  ReportToUser(Map<String, dynamic> data){
    _data = data;
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new MainText("Жалоба на: " + _data['Name']),
            new Container(height: 20,),
            new MainText("Введите свою жалобу:"),
            new TextareaRasp(textChangedMessage),
            new ButtonWidget("Отправить", clickAddButton),
          ],
        ),
      ),
      constraints: BoxConstraints.expand(),
    );
  }
}
