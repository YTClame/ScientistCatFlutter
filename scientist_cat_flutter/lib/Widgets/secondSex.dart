import 'package:flutter/material.dart';

enum SecondSexEnum { man, woman }

class SecondSex extends StatefulWidget {
  Function _callback;

  SecondSex(this._callback, [String value]) {
    if(value == null)
      _sss = new _SecondSexState(_callback);
    else
      _sss = new _SecondSexState(_callback, value);
  }

  _SecondSexState _sss;

  @override
  createState() => _sss;
}

class _SecondSexState extends State<SecondSex> {
  SecondSexEnum _sex = SecondSexEnum.man;
  Function _callback;

  _SecondSexState(this._callback, [String value]){
    if(value != null)
      _sex = value == "Мужской" ? SecondSexEnum.man : SecondSexEnum.woman;
  }

  Widget build(BuildContext context) {
    if(_sex == SecondSexEnum.man)
      _callback(context, "Мужской");
    else
      _callback(context, "Женский");
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
              value: SecondSexEnum.man,
              groupValue: _sex,
              onChanged: (SecondSexEnum sex) {
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
              value: SecondSexEnum.woman,
              groupValue: _sex,
              onChanged: (SecondSexEnum sex) {
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
