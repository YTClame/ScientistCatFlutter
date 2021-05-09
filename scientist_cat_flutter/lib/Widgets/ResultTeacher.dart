import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/lkSecondText.dart';

import '../Settings.dart';
import 'textFoundResult.dart';

class ResultTeacher extends StatelessWidget {
  final String _secondName;
  final String _firstName;
  final String _education;
  final String _stash;
  final String _price;
  final String _photo;
  final String _id;

  ResultTeacher(this._secondName, this._firstName, this._education, this._stash,
      this._price, this._photo, this._id);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {},
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          border: new Border.all(color: Colors.black),
          color: Color.fromRGBO(83, 162, 255, 1.0),
        ),
        margin: EdgeInsets.only(bottom: 10.0),
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
                    new FoundResultText("Фамилия: " + _secondName),
                    new FoundResultText("Имя: " + _firstName),
                    new FoundResultText("Образование: " + _education),
                    new FoundResultText("Стаж: " + _stash),
                    new FoundResultText("Ставка: " + _price),
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
