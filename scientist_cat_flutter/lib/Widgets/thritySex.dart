import 'package:flutter/material.dart';

enum ThritySexEnum { man, woman, all }

class ThritySex extends StatefulWidget {
  Function _callback;

  ThritySex(this._callback, [String value]) {
    if(value == null)
      _sss = new _ThritySexState(_callback);
    else
      _sss = new _ThritySexState(_callback, value);
  }

  _ThritySexState _sss;

  @override
  createState() => _sss;
}

class _ThritySexState extends State<ThritySex> {
  ThritySexEnum _sex = ThritySexEnum.all;
  Function _callback;

  _ThritySexState(this._callback, [String value]){
    if(value != null){
      if(value == "Мужской")
        _sex = ThritySexEnum.man;
      else if(value == "Женский")
        _sex = ThritySexEnum.woman;
      else if(value == "Любой")
        _sex = ThritySexEnum.all;
    }
  }

  Widget build(BuildContext context) {
    if(_sex == ThritySexEnum.man)
      _callback(context, "Мужской");
    else if(_sex == ThritySexEnum.woman)
      _callback(context, "Женский");
    else
      _callback(context, "Любой");
    return new Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Мужской',
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            leading: Radio(
              value: ThritySexEnum.man,
              groupValue: _sex,
              onChanged: (ThritySexEnum sex) {
                setState(() {
                  _sex = sex;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Женский',
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            leading: Radio(
              value: ThritySexEnum.woman,
              groupValue: _sex,
              onChanged: (ThritySexEnum sex) {
                setState(() {
                  _sex = sex;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Любой',
              style: new TextStyle(
                fontFamily: 'InputFont',
                fontSize: 22,
              ),
            ),
            leading: Radio(
              value: ThritySexEnum.all,
              groupValue: _sex,
              onChanged: (ThritySexEnum sex) {
                setState(() {
                  _sex = sex;
                });
              },
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 20.0),
    );
  }
}
