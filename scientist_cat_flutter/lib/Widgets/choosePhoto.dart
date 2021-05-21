import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scientist_cat_flutter/Widgets/button.dart';
import 'package:toast/toast.dart';

import '../Settings.dart';

class ChoosePhoto extends StatefulWidget {
  Function _callback;
  Map<String, dynamic> _info;

  ChoosePhoto(this._info) {
    _sss = new _ChoosePhotoState(_info);
  }

  _ChoosePhotoState _sss;

  @override
  createState() => _sss;
}

class _ChoosePhotoState extends State<ChoosePhoto> {
  Map<String, dynamic> _info;
  File _image;

  _ChoosePhotoState(this._info) {
    if (_info['Image'] != null)
      _image = _info['Image'];

    //_image = Image.asset('images/avatar.jpg');
    //_image = File.fromRawPath('images/avatar.jpg');
  }

  Future<PickedFile> _getImage() async {
    ImagePicker ip = new ImagePicker();
    return ip.getImage(source: ImageSource.gallery);
  }

  void _loadingImage(BuildContext context, PickedFile pf){
    if(pf == null)
      return;
    _image = File(pf.path);
    String rashir = "";
    rashir = pf.path.split(".")[pf.path.split(".").length - 1];
    if(rashir != "png" && rashir != "jpg" && rashir != "jpeg" && rashir != "bmp"){
      _image = null;
      Toast.show("Выберите файл расширения png, jpg, jpeg или bmp!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    setState(() {

    });
  }

  void _clickToButton(BuildContext context) {
    _getImage().then((value) => _loadingImage(context, value));
  }

  void _clickToButtonAccept(BuildContext context) {
    _info['UploadCallback'](context, _image);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    if (_image == null)
      return new Container(
        child: new Center(
          child: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 10,
                ),
                Image.network(
                  Settings().getHost() + Settings().getUserInfo()['Фото'],
                  width: 300,
                ),
                Container(
                  height: 10,
                ),
                new ButtonWidget("Выбрать", _clickToButton),
                Container(
                  height: 10,
                ),
                new ButtonWidget("Подтвердить", _clickToButtonAccept),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    else
      return new Container(
        child: new Center(
          child: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 10,
                ),
                Image.file(
                  _image,
                  width: 300,
                ),
                Container(
                  height: 10,
                ),
                new ButtonWidget("Выбрать", _clickToButton),
                Container(
                  height: 10,
                ),
                new ButtonWidget("Подтвердить", _clickToButtonAccept),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
