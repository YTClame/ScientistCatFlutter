import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scientist_cat_flutter/Widgets/Message.dart';
import 'package:scientist_cat_flutter/Widgets/textMessageWidget.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class Messenger extends StatefulWidget {
  Messenger(Function _callback, List<dynamic> _mes) {
    List<Map<String, dynamic>> _mes2 = [];
    for (dynamic d in _mes) {
      _mes2.add(d as Map<String, dynamic>);
    }

    _sss = new _MessengerState(
        _callback, _mes2, Settings().getTempMessengerUserId());
  }


  _MessengerState _sss;

  @override
  createState() => _sss;

}

class _MessengerState extends State<Messenger> {
  List<Map<String, dynamic>> _mes;
  Function _callback;
  String _message;
  int _id;
  Timer _messagerTimer;
  String _token;

  _MessengerState(this._callback, this._mes, this._id) {
    _message = "";
    _messagerTimer = new Timer.periodic(
        new Duration(seconds: 4), (Timer t) => _getMessagesLength());
    _token = Settings().getToken();
  }

  void _getMessagesLength() {
    API.getMessegesLength(_token, _id).then((size) =>
        _gettedMessagesLength(size));
  }

  void _gettedMessagesLength(int size) {
    if (size != _mes.length) {
      API.loadMesseges(_token, _id).then((value) => _updateMessages(value['Messages']));
    }
  }

  void _updateMessages(List<dynamic> mes) {
    List<Map<String, dynamic>> l = new List<Map<String, dynamic>>.from(mes);
    this._mes = l;
    setState(() {
      
    });
  }

  ScrollController _sc = new ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToDown();
    });
  }

  @override
  void dispose() {
    _messagerTimer.cancel();
    super.dispose();
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

  Widget build(BuildContext context) {
    int _myId = Settings().getUserInfo()['ID'];
    return new Container(
      child: new Column(children: [
        new Expanded(
          child: new Container(
            child: SingleChildScrollView(
              child: new Column(
                children: _mes
                    .map<Widget>((oneMes) => new Message(oneMes, _myId, () {}))
                    .toList(),
              ),
              controller: _sc,
            ),
          ),
        ),
        new Container(
          color: Colors.black,
          height: 50,
          child: new Align(
            alignment: Alignment.bottomCenter,
            child: new Row(children: [
              new TextMessageWidget(inputChanged, _message),
              new Container(
                width: 1,
              ),
              new Container(
                child: new GestureDetector(
                  onTap: () {
                    _sendMessage(context);
                  },
                  child: Image.asset(
                    "images/send.png",
                    height: 49,
                    width: 49,
                  ),
                ),
                width: 49,
                color: Color.fromRGBO(0, 117, 255, 1.0),
              )
            ]),
          ),
        ),
      ]),
      constraints: BoxConstraints.expand(),
    );
  }

  void inputChanged(BuildContext context, String s) {
    _message = s;
  }

  String _mesSended = "";

  void _sendMessage(BuildContext bContext) {
    _mesSended = _message;
    API
        .sendMessege(Settings().getToken(), Settings().getTempMessengerUserId(),
        _message)
        .then((value) => _sendCallback(value, bContext));
  }

  void _sendCallback(String res, BuildContext context) {
    if (res != "Error") {
      Map<String, dynamic> newMes = new Map();
      newMes['Отправитель'] = Settings().getUserInfo()['ID'];
      newMes['Сообщение'] = _mesSended;
      Map<String, dynamic> res2 = jsonDecode(res);
      newMes['Дата'] = res2['Дата'];
      newMes['Время'] = res2['Время'];
      _mes.add(newMes);
      _message = "";
      setState(() {});
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollToDown();
      });
    } else {
      Toast.show("Ошибка отправки!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
