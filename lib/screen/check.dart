import 'package:flutter/material.dart';
import 'package:module_a_101/controller/controller.dart';
import 'package:module_a_101/screen/home.dart';
import 'package:module_a_101/utills.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Check() {
  Controller.focusDay = Controller.focusDay;

  return Column(
    spacing: 15,
    children: [
      Y(1, '이름 : ${Controller.namecon.text}', width: 300),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Y(2, '나이 : ${Controller.agecon.text}세', width: 230),
          GestureDetector(
            onTap: () {
              Controller.current.value = 3;
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                Controller.man
                    ? 'assets/icon/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg'
                    : 'assets/icon/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
              ),
            ),
          ),
        ],
      ),
      Y(4, '생일 : ${format('yyyy.MM.dd', Controller.focusDay)}'),
      Y(5, format('태어난 시간 : HH:mm', Controller.focusDay)),

      // Text(format('HH:mm', Controller.focusDay),style: TextStyle(color: Colors.white,fontSize: 20),)
    ],
  );
}

Widget Y(int i, String info, {double width = 300}) => GestureDetector(
  onTap: () {
    Controller.current.value = i;
    // print(format('hh : mm', Controller.focusDay));
    // print(Controller.focusDay);
  },
  child: Container(
    padding: EdgeInsets.only(left: 30),
    alignment: Alignment.centerLeft,
    height: 60,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white),
    ),
    child: Text('$info', style: TextStyle(color: Colors.white, fontSize: 18)),
  ),
);
