import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/raspAddButton.dart';
import 'package:scientist_cat_flutter/Widgets/raspNameOfDay.dart';

import 'oneRaspElem.dart';
import 'oneRaspElemUser.dart';

class OneDayRaspUser extends StatelessWidget {
  final String _nameOfDay;
  final List<Map<String, dynamic>> _tasks;
  OneDayRaspUser(this._nameOfDay, this._tasks);
  @override
  Widget build(BuildContext context) {
    if(_tasks.length == 0){
      return Container();
    }
    return new Column(
      children: [
        RaspNameOfDay(_nameOfDay),
        new Column(
          children: _tasks
              .map<Widget>((one) => new OneRaspElemUser(one['От'], one['До'], one['Занятие'], _nameOfDay))
              .toList(),
        ),
      ],
    );
  }
}