import 'dart:developer';

import 'package:flutter/material.dart';

class DroppedList extends StatefulWidget {
  List<String> _cities;
  String _cityChoice;
  Function _callback;

  DroppedList(this._cities, this._cityChoice, this._callback) {
    _dls = new DroppedListState(_cities, _cityChoice, _callback);
  }

  DroppedListState _dls;

  @override
  createState() => _dls;
}

class DroppedListState extends State<DroppedList> {
  List<String> _cities;
  String _cityMain;
  Function _callback;

  DroppedListState(this._cities, this._cityMain, this._callback);

  void update(String cityChanged, List<String> cities) {
    setState(() {
      _cities = cities;
      _cityMain = cityChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    _callback(context, _cityMain);
    return new Container(
      child: new DropdownButton<String>(
        value: _cityMain,
        items: _cities.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(
              value,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontFamily: 'MainFont',
                fontSize: 24,
              ),
            ),
          );
        }).toList(),
        onChanged: (city) {
          update(city, _cities);
        },
      ),
      width: 300,
      padding: EdgeInsets.fromLTRB(9.0, 3.0, 3.0, 3.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black),
        color:Color.fromRGBO(247, 245, 204, 1.0),
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
