import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

import 'Settings.dart';

class API {
  static Future<String> getHost() async {
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Uri url;
    url = Uri.parse("https://pastebin.com/raw/wbTbhsmJ");
    var response = await get(url, headers: headers);
    return response.body;
  }

  static Future<Map<String, dynamic>> login(String login, String password) async {
    final url = Uri.parse(Settings().getHost() + 'api/login');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String data = "login=" + login + "&password=" + password;
    Response response = await post(url,
        headers: headers, body: data); // check the status code for the result
    int statusCode = response
        .statusCode; // this API passes back the id of the new item added to the body
    String body = response.body;
    Map<String, dynamic> resMap;
    if(body != "Error"){
      resMap = jsonDecode(body);
    }
    else{
      resMap = new Map();
      resMap['Токен'] = "Error";
    }
    return resMap;
  }

  static Future<List<String>> getCities() async {
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    final url = Uri.parse(Settings().getHost() + 'api/getCityNames');
    var response = await get(url, headers: headers);
    List<dynamic> citiesMap = jsonDecode(response.body);
    List<String> cities = [];
    for (dynamic city in citiesMap) cities.add(city['Name']);
    return cities;
  }

  static Future<Map<String, dynamic>> getInfoAboutUserForToken(String token, String role) async {
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Uri url;
    if(role == "Репетитор"){
      url = Uri.parse(Settings().getHost() + 'api/getInformationAboutTeacher?token=' + token);
    }
    if(role == "Ученик"){
      url = Uri.parse(Settings().getHost() + 'api/getInformationAboutStudent?token=' + token);
    }
    var response = await get(url, headers: headers);
    Map<String, dynamic> res;
    if(response.body == "Error"){
      res = new Map();
      res['Статус'] = "Error";
      return res;
    }
     res = jsonDecode(response.body);
    res['Статус'] = "Успех";
    return res;
  }

  static Future<List<String>> newTeacher(
      String city,
      String secondName,
      String firstName,
      String birth,
      String stot,
      String ttos,
      String distant,
      String edu,
      String stash,
      String sex,
      String phone,
      String login,
      String password,
      String email,
      String math,
      String rus,
      String phis,
      String inf,
      String chem,
      String bio,
      String hist,
      String soc,
      String lit,
      String geo,
      String eco,
      String eng,
      String nem,
      String price,
      String solo,
      String group,
      String homework,
      String standart) async {
    final url = Uri.parse(Settings().getHost() + 'api/registerTeacher');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String data = "city=" +
        Uri.encodeComponent(city).trim() +
        "&secondName=" +
        Uri.encodeComponent(secondName).trim() +
        "&firstName=" +
        Uri.encodeComponent(firstName).trim() +
        "&birth=" +
        Uri.encodeComponent(birth).trim() +
        "&stot=" +
        stot +
        "&ttos=" +
        ttos +
        "&dist=" +
        distant +
        "&edu=" +
        Uri.encodeComponent(edu).trim() +
        "&stash=" +
        Uri.encodeComponent(stash).trim() +
        "&sex=" +
        sex +
        "&phone=" +
        Uri.encodeComponent(phone).trim() +
        "&login=" +
        Uri.encodeComponent(login).trim() +
        "&pass=" +
        Uri.encodeComponent(password).trim() +
        "&email=" +
        Uri.encodeComponent(email).trim() +
        "&math=" +
        math +
        "&rus=" +
        rus +
        "&phis=" +
        phis +
        "&inf=" +
        inf +
        "&chem=" +
        chem +
        "&bio=" +
        bio +
        "&hist=" +
        hist +
        "&soc=" +
        soc +
        "&lit=" +
        lit +
        "&geo=" +
        geo +
        "&eco=" +
        eco +
        "&eng=" +
        eng +
        "&nem=" +
        nem +
        "&price=" +
        price +
        "&solo=" +
        solo +
        "&group=" +
        group +
        "&home=" +
        homework +
        "&standart=" +
        standart;

    Response response = await post(url,
        headers: headers, body: data); // check the status code for the result
    int statusCode = response
        .statusCode; // this API passes back the id of the new item added to the body
    String body = response.body;
    List<String> res = [];
    if (body.substring(0, 7) == "token: ") {
      res.add("OK");
      res.add(body.substring(7));
    } else {
      res.add("Error");
      res.add(body);
    }
    return res;
  }


  static Future<List<String>> newStudent(
      String city,
      String secondName,
      String firstName,
      String birth,
      String classNumber,
      String stot,
      String ttos,
      String distant,
      String sex,
      String phone,
      String login,
      String password,
      String email,
      String math,
      String rus,
      String phis,
      String inf,
      String chem,
      String bio,
      String hist,
      String soc,
      String lit,
      String geo,
      String eco,
      String eng,
      String nem) async {
    final url = Uri.parse(Settings().getHost() + 'api/registerStudent');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String data = "city=" +
        Uri.encodeComponent(city).trim() +
        "&secondName=" +
        Uri.encodeComponent(secondName).trim() +
        "&firstName=" +
        Uri.encodeComponent(firstName).trim() +
        "&birth=" +
        Uri.encodeComponent(birth).trim() +
        "&class=" +
        Uri.encodeComponent(classNumber).trim() +
        "&stot=" +
        stot +
        "&ttos=" +
        ttos +
        "&dist=" +
        distant +
        "&sex=" +
        sex +
        "&phone=" +
        Uri.encodeComponent(phone).trim() +
        "&login=" +
        Uri.encodeComponent(login).trim() +
        "&pass=" +
        Uri.encodeComponent(password).trim() +
        "&email=" +
        Uri.encodeComponent(email).trim() +
        "&math=" +
        math +
        "&rus=" +
        rus +
        "&phis=" +
        phis +
        "&inf=" +
        inf +
        "&chem=" +
        chem +
        "&bio=" +
        bio +
        "&hist=" +
        hist +
        "&soc=" +
        soc +
        "&lit=" +
        lit +
        "&geo=" +
        geo +
        "&eco=" +
        eco +
        "&eng=" +
        eng +
        "&nem=" +
        nem;

    Response response = await post(url,
        headers: headers, body: data); // check the status code for the result
    int statusCode = response
        .statusCode; // this API passes back the id of the new item added to the body
    String body = response.body;
    List<String> res = [];
    if (body.substring(0, 7) == "token: "){
      res.add("OK");
      res.add(body.substring(7));
    }
    else{
      res.add("Error");
      res.add(body);
    }
    return res;
  }


  static Future<List<Map<String, dynamic>>> foundTeacher(Map<String, dynamic> filter) async {
    final url = Uri.parse(Settings().getHost() + 'api/foundTeacher');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String data = "stot=" + filter['stot'] +
        "&ttos=" + filter['ttos'] +
        "&dist=" + filter['dist'] +
        "&sex=" + filter['sex'] +
        "&math=" + filter['math'] +
        "&rus=" + filter['rus'] +
        "&phis=" + filter['phis'] +
        "&inf=" + filter['inf'] +
        "&chem=" + filter['chem'] +
        "&bio=" + filter['bio'] +
        "&hist=" + filter['hist'] +
        "&soc=" + filter['soc'] +
        "&lit=" + filter['lit'] +
        "&geo=" + filter['geo'] +
        "&eco=" + filter['eco'] +
        "&eng=" + filter['eng'] +
        "&nem=" + filter['nem'] +
        "&minS=" + filter['minS'] +
        "&maxS=" + filter['maxS'] +
        "&minP=" + filter['minP'] +
        "&maxP=" + filter['maxP'] +
        "&edS=" + filter['edS'] +
        "&edA=" + filter['edA'] +
        "&edT=" + filter['edT'] +
        "&edP=" + filter['edP'] +
        "&token=" + filter['token'];

    Response response = await post(url,
        headers: headers, body: data); // check the status code for the result
    int statusCode = response
        .statusCode; // this API passes back the id of the new item added to the body
    String body = response.body;
    List<dynamic> listRes = jsonDecode(body) as List;
    List<Map<String, dynamic>> res = [];
    for(Map<String, dynamic> map in listRes)
      res.add(map);
    return res;
  }

  static Future<List<Map<String, dynamic>>> foundStudent(Map<String, dynamic> filter) async {
    final url = Uri.parse(Settings().getHost() + 'api/foundStudent');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String data = "stot=" + filter['stot'] +
        "&ttos=" + filter['ttos'] +
        "&dist=" + filter['dist'] +
        "&minClass=" + filter['minClass'] +
        "&maxClass=" + filter['maxClass'] +
        "&sex=" + filter['sex'] +
        "&math=" + filter['math'] +
        "&rus=" + filter['rus'] +
        "&phis=" + filter['phis'] +
        "&inf=" + filter['inf'] +
        "&chem=" + filter['chem'] +
        "&bio=" + filter['bio'] +
        "&hist=" + filter['hist'] +
        "&soc=" + filter['soc'] +
        "&lit=" + filter['lit'] +
        "&geo=" + filter['geo'] +
        "&eco=" + filter['eco'] +
        "&eng=" + filter['eng'] +
        "&nem=" + filter['nem'] +
        "&token=" + filter['token'];

    Response response = await post(url,
        headers: headers, body: data); // check the status code for the result
    int statusCode = response
        .statusCode; // this API passes back the id of the new item added to the body
    String body = response.body;
    List<dynamic> listRes = jsonDecode(body) as List;
    List<Map<String, dynamic>> res = [];
    for(Map<String, dynamic> map in listRes)
      res.add(map);
    return res;
  }

  static Future<Map<String, dynamic>> loadInfoAboutTeacher(String id) async {
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Uri url;
    url = Uri.parse(Settings().getHost() + 'api/getInformationAboutTeacher?id=' + id);
    var response = await get(url, headers: headers);
    return jsonDecode(response.body);
  }
}
