import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scientist_cat_flutter/Pages/authWidget.dart';

void main() async {
  await GetStorage.init();
  runApp(
    new AuthWidget()
  );
}