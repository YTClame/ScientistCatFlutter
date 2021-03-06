import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class OneRaspElem extends StatelessWidget {
  final String _timeStart;
  final String _timeEnd;
  final String _task;
  final String _day;

  Function _updateCallback;
  Function _editCallback;

  OneRaspElem(this._timeStart, this._timeEnd, this._task, this._day,
      this._updateCallback, this._editCallback);

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
            Container(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _editRaspElem(context);
                  },
                  child: Image.asset(
                    "images/edit.png",
                    width: 27,
                    height: 27,
                  ),
                ),
                Container(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _removeElem(context);
                  },
                  child: Image.asset(
                    "images/trash.png",
                    width: 27,
                    height: 27,
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

  void _removeElem(BuildContext context) {
    String dayRes;
    if(_day == "??????????????????????")
      dayRes = "????";
    else if(_day == "??????????????")
      dayRes = "????";
    else if(_day == "??????????")
      dayRes = "????";
    else if(_day == "??????????????")
      dayRes = "????";
    else if(_day == "??????????????")
      dayRes = "????";
    else if(_day == "??????????????")
      dayRes = "????";
    else if(_day == "??????????????????????")
      dayRes = "????";
    else
      dayRes = _day;

    API.removeRaspElem(Settings().getToken(), dayRes, _timeStart, _timeEnd, _task).then((value) => _continueRemove(context, value));
  }

  void _continueRemove(BuildContext context, String res){
    if(res == "Error"){
      Toast.show("???????????? ????????????????!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    else{
      _updateCallback();
    }
  }

  void _editRaspElem(BuildContext context){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['UpdateF'] = _updateCallback;
    map['????????'] = _day;
    map['time1'] = _timeStart;
    map['time2'] = _timeEnd;
    map['task'] = _task;
    _editCallback(context, map);
  }
}
