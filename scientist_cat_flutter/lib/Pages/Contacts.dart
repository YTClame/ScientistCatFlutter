import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/OneContact.dart';
import 'package:scientist_cat_flutter/Widgets/ResultStudent.dart';
import 'package:scientist_cat_flutter/Widgets/ResultTeacher.dart';
import 'package:scientist_cat_flutter/Widgets/StudentFilter.dart';
import 'package:scientist_cat_flutter/Widgets/TeacherFilter.dart';

import '../APIs.dart';

class Contacts extends StatelessWidget {
  List<Map<String, dynamic>> _contacts;
  Function _callback;

  Contacts(this._callback, this._contacts);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new Container(height: 10.0,),
            new Column(
              children: _contacts
                  .map<Widget>((contact) => new OneContact(
                  contact['Фамилия'],
                  contact['Имя'],
                  contact['Статус'].toString(),
                  contact['Фото'],
                  contact['ID'],
                  _callback))
                  .toList(),
            )
          ]
        ),
      ),
      //color: Color.fromRGBO(198, 224, 255, 1.0),
      constraints: BoxConstraints.expand(),
    );
  }
}
