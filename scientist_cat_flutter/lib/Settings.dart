import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class Settings {
  //One instance, needs factory
  static final Settings _singleton = Settings._internal();
  final box = GetStorage();

  factory Settings() {
    return _singleton;
  }

  Settings._internal();


  String _host ='http://192.168.1.100:5000/';
  String getHost(){
    return _host;
  }

  String getToken(){
    try{
      String token = box.read('token');
      return token;
    }
    catch(e){
      return "";
    }
  }

  void setToken(String token){
    box.write('token', token);
  }

}