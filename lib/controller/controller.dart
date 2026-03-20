import 'package:flutter/material.dart';

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

  static int Moon = 0;
}