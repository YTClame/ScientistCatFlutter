import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/textFoundResult.dart';

import '../APIs.dart';
import '../Settings.dart';
import 'StatusText.dart';

class OneContact extends StatelessWidget {
  final String _secondName;
  final String _firstName;
  final String _status;
  final String _photo;
  final int _id;
  final Function _callback;

  OneContact(this._secondName, this._firstName, this._status, this._photo,
      this._id, this._callback);

  void _loadMesseges(BuildContext context){
    Settings().setTempMessenerUserId(_id);
    API.loadMesseges(Settings().getToken(), _id).then((res) => {_openPage(context, res)});
  }

  void _openPage(BuildContext context, Map<String, dynamic> res){
    _callback(context, res);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {_loadMesseges(context);},
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          border: new Border.all(color: Colors.black),
          color: Color.fromRGBO(83, 162, 255, 1.0),
        ),
        margin: EdgeInsets.only(bottom: 10.0,),
        child: new Row(
          children: [
            new Expanded(
              flex: 2,
              child: new Padding(
                padding: EdgeInsets.all(5.0),
                child: new Container(
                  decoration: BoxDecoration(
                    border: new Border.all(color: Colors.black),
                  ),
                  child:
                  Image.network(Settings().getHost() + _photo.substring(1)),
                ),
              ),
            ),
            new Expanded(
              flex: 5,
              child: new Padding(
                padding: EdgeInsets.only(right: 5.0, left: 5.0),
                child: new Column(
                  children: [
                    new FoundResultText(_secondName),
                    new FoundResultText(_firstName),
                    new StatusText(_status),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}