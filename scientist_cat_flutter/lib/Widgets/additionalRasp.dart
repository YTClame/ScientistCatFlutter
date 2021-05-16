import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/oneDayRasp.dart';
import 'package:scientist_cat_flutter/Widgets/raspNameOfDay.dart';

import 'oneRaspElem.dart';

class AdditionalRasp extends StatelessWidget {
  final Map<String, dynamic> _tasks;
  Function _buttonCallback;
  Function _updateCallback;
  AdditionalRasp(this._tasks, this._buttonCallback, this._updateCallback);
  @override
  Widget build(BuildContext context) {
    return new Column(
        children: _tasks.entries.map((entry) {
          List<Map<String, dynamic>> list = new List<Map<String, dynamic>>.from(entry.value);
          String date = entry.key;
          var w = new OneDayRasp(date, list, _buttonCallback, _updateCallback);
          return w;
        }).toList());
  }
}