import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../APIs.dart';
import '../Settings.dart';

class ButtonWidgetAW extends StatefulWidget {
  ButtonWidgetAW(Function _callback, String access, int id) {
    _sss = new _ButtonWidgetAWState(_callback, access, id);
  }

  _ButtonWidgetAWState _sss;

  @override
  createState() => _sss;
}

class _ButtonWidgetAWState extends State<ButtonWidgetAW> {
  Function _callback;
  String _access;
  String _textOnButton;
  int _id;

  _ButtonWidgetAWState(this._callback, this._access, this._id) {
    _updateTextOnButton();
  }

  void _updateTextOnButton() {
    _textOnButton = _access == "Открыт" ? "Заблокировать" : "Разблокировать";
  }

  void _changeBlockingStatus(BuildContext context) {
    if (_access == "Открыт")
      API
          .blockUser(Settings().getToken(), _id)
          .then((value) => _handleBlockingRes(context, value));
    else if (_access == "Закрыт")
      API
          .unblockUser(Settings().getToken(), _id)
          .then((value) => _handleBlockingRes(context, value));
  }

  void _handleBlockingRes(BuildContext context, String res) {
    if (res == "Error")
      Toast.show("Ошибка при изменении доступа пользователю!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    else if (res == "OK"){
      _access = "Закрыт";
      _textOnButton = _textOnButton == "Заблокировать" ? "Разблокировать" : "Заблокировать";
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return new Container(
      width: 300,
      height: 48,
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black),
        color: Color.fromRGBO(83, 162, 255, 1.0),
      ),
      child: new ElevatedButton(
        onPressed: () {
          _changeBlockingStatus(context);
        },
        child: new Padding(
          padding: EdgeInsets.only(top: 9.0),
          child: new Text(
            _textOnButton,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: 'MainFont',
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
