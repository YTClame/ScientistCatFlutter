import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/raspAddButton.dart';
import 'package:scientist_cat_flutter/Widgets/raspNameOfDay.dart';

import 'oneRaspElem.dart';

class OneDayRasp extends StatelessWidget {
  final String _nameOfDay;
  final List<Map<String, dynamic>> _tasks;
  Function _buttonCallback;
  Function _updateCallback;
  Function _editCallback;
  OneDayRasp(this._nameOfDay, this._tasks, this._buttonCallback, this._updateCallback, this._editCallback);
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        RaspNameOfDay(_nameOfDay),
        new Column(
          children: _tasks
              .map<Widget>((one) => new OneRaspElem(one['От'], one['До'], one['Занятие'], _nameOfDay, _updateCallback, _editCallback))
              .toList(),
        ),
        RaspAddButton("Добавить", _buttonCallback, _nameOfDay),
      ],
    );
  }
}