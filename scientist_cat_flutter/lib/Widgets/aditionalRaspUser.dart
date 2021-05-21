import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/oneDayRasp.dart';
import 'package:scientist_cat_flutter/Widgets/raspNameOfDay.dart';

import 'oneDayRaspUser.dart';
import 'oneRaspElem.dart';

class AdditionalRaspUser extends StatelessWidget {
  final Map<String, dynamic> _tasks;
  AdditionalRaspUser(this._tasks);
  @override
  Widget build(BuildContext context) {
    return new Column(
        children: _tasks.entries.map((entry) {
          List<Map<String, dynamic>> list = new List<Map<String, dynamic>>.from(entry.value);
          String date = entry.key;
          var w = new OneDayRaspUser(date, list);
          return w;
        }).toList());
  }
}