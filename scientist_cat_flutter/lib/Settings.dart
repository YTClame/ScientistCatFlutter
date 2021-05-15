import 'dart:async';
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

  String _host = '';

  String getHost() {
    return _host;
  }

  String setHost(String host) {
    this._host = host;
  }

  String getToken() {
    String token = box.read('token');
    if (token == null) return "";
    return token;
  }

  void setToken(String token) {
    box.write('token', token);
  }

  String getRole() {
    String role = box.read('role');
    if (role == null) return "";
    return role;
  }

  void setRole(String role) {
    box.write('role', role);
  }

  List<String> _cities = [];
  List<String> getCities(){
    return _cities;
  }
  void setCities(List<String> cities){
    _cities = cities;
  }

  Map<String, dynamic> _userInfo;

  Map<String, dynamic> getUserInfo() {
    return _userInfo;
  }

  void setUserInfo(Map<String, dynamic> userInfo) {
    this._userInfo = userInfo;
  }

  int _tempMessegerUserId;
  void setTempMessenerUserId(int id){
    _tempMessegerUserId = id;
  }
  int getTempMessengerUserId(){
    return _tempMessegerUserId;
  }

}
