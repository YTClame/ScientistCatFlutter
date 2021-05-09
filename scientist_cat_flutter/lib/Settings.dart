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


  String _host ='';
  String getHost(){
    return _host;
  }
  String setHost(String host){
    this._host = host;
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

  String getRole(){
    try{
      String role = box.read('role');
      return role;
    }
    catch(e){
      return "";
    }
  }

  void setRole(String role){
    box.write('role', role);
  }

  Map<String, dynamic> _userInfo;
  Map<String, dynamic> getUserInfo(){
    return _userInfo;
  }
  void setUserInfo(Map<String, dynamic> userInfo){
    this._userInfo = userInfo;
  }

}