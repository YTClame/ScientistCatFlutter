import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scientist_cat_flutter/Widgets/MessageAW.dart';

import '../Settings.dart';




class MessengerAW extends StatelessWidget {
  ScrollController _sc;
  List<Map<String, dynamic>> _mes;
  int _badID;

  MessengerAW(this._mes, this._badID){
    _sc = new ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToDown();
    });
  }

  void _scrollToDown() {
    var scrollPosition = _sc.position;
    if (scrollPosition.maxScrollExtent > scrollPosition.minScrollExtent) {
      _sc.animateTo(
        scrollPosition.maxScrollExtent,
        duration: new Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(children: [
        new Expanded(
          child: new Container(
            child: SingleChildScrollView(
              child: new Column(
                children: _mes
                    .map<Widget>((oneMes) => new MessageAW(oneMes, _badID))
                    .toList(),
              ),
              controller: _sc,
            ),
          ),
        ),
      ]),
      constraints: BoxConstraints.expand(),
      color: Color.fromRGBO(235, 235, 235, 1.0),
    );
  }
}