import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';
import 'package:scientist_cat_flutter/Pages/lkAdapter.dart';

import 'APIs.dart';
import 'Settings.dart';

void main() async {
  await GetStorage.init();
  API.getHost().then((value) => {
    Settings().setHost(value)
  });
  runApp(
    new AuthWidget()
    //new LkAdapter("_title")
  );
}