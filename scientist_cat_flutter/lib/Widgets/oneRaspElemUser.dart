import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class OneRaspElemUser extends StatelessWidget {
  final String _timeStart;
  final String _timeEnd;
  final String _task;
  final String _day;

  OneRaspElemUser(this._timeStart, this._timeEnd, this._task, this._day);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Padding(
        child: new Column(
          children: [
            new Row(
              children: [
                new Text(
                  _timeStart + "-" + _timeEnd,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontFamily: 'InputFont',
                    fontSize: 18,
                    color: Colors.indigo,
                  ),
                ),
                Container(
                  width: 10,
                ),
                Flexible(
                  child: new Text(
                    _task,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: 'InputFont',
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
      ),
      width: 300,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          )),
    );
  }
}
