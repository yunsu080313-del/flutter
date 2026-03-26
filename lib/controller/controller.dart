import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller {
  // static final name = TextEditingController();

  static ValueNotifier<int> current = ValueNotifier(0);
  static int get currentindex => current.value;

  static TextEditingController namecon = TextEditingController();
  static TextEditingController agecon = TextEditingController();
  static bool man = true;

  static DateTime focusDay = DateTime.now();
  static DateTime borntime = DateTime(0);

  static double angle = 0;
  static int hour = 6;
  static int minute = 0;
  static bool isHour = true;
  static bool isAm = true;

  static ValueNotifier<int> Moon  = ValueNotifier(0);
  static Future<void> saveMoon() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Moon', Moon.value);
  }

  static Future<void> loadMoon() async {
    final prefs = await SharedPreferences.getInstance();
    Moon.value = prefs.getInt('Moon') ?? 10;
  }

  static Future loadJson(String link,int index) async {
    final String response = await rootBundle.loadString(link);
    final data = await json.decode(response);
    for (int i = 0; i < 9; i++) {
      if (data[i]['number'] == index) {
        print(data);
        return data[i];
      }
    }
  }
}