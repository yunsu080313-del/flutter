import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module_a_101/controller/controller.dart';
import 'package:module_a_101/screen/calender.dart';
import 'package:module_a_101/screen/check.dart';
import 'package:module_a_101/screen/clock.dart';
import 'package:module_a_101/screen/cloud.dart';
import 'package:module_a_101/screen/gender.dart';
import 'package:module_a_101/screen/input.dart';
import 'package:module_a_101/screen/main.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  final duration = Duration(milliseconds: 1000);
  bool moon = false;
  bool anilogo = false;
  bool anibutton = false;

  final text = [
    '운명을 엿볼 시간이에요.',
    '이름을 입력해주세요.',
    '나이를 입력해주세요.',
    '성별을 입력해주세요.',
    '태어난 날짜를 입력해주세요.',
    '태어난 시간을 입력해주세요.',
    '입력한 정보가 맞는지 확이해주세요.',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Controller.loadMoon();
      moon = false;
      anilogo = false;
      anibutton = false;
      setState(() {});
      await Future.delayed(duration);
      setState(() {
        moon = true;
        anilogo = true;
      });
      await Future.delayed(duration);
      setState(() {
        anibutton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Controller.current,

      builder: (context, value, child) {
        final screen = [
          button(anibutton),
          inputField(context, '이름을 입력해주세요.', '이름은 최소 2자, 최대 20까지 가능합니다.', true),
          inputField(context, '나이를 입력해주세요.', '나이는 숫자만 입력 가능합니다', false),
          gender(),
          calender(context),
          FastClock(),
          Check(),
        ];

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff4f118f), Color(0xff1f002f)],
                  ),
                ),
                child: Column(
                  children: [
                    AnimatedOpacity(
                      duration: duration,
                      opacity: moon ? 1 : 0,
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Image.asset(
                          'assets/image/moon.png',
                          height: 140,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: duration,
                      height: anilogo && Controller.currentindex == 0 ? 80 : 0,
                    ),
                    AnimatedOpacity(
                      duration: duration,
                      opacity: anilogo ? 1 : 0,
                      child: logo(text[Controller.currentindex]),
                    ),
                    SizedBox(height: Controller.currentindex == 0 ? 110 : 50),
                    AnimatedOpacity(
                      duration: duration,
                      opacity: anilogo ? 1 : 0,

                      child: screen[Controller.currentindex],
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: moon ? 1 : 0,
                  duration: duration,
                  child: cloud(context),
                ),
              ),
              // Positioned(
              //   bottom: 100,
              //   child: AnimatedOpacity(
              //     duration: duration,
              //     opacity: anilogo ? 1 : 0,
              //     child: screen[Controller.currentindex],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

Widget button(bool anibutton) => GestureDetector(
  onTap: () {
    Controller.current.value += 1;
  },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 1000),
    alignment: Alignment.center,
    height: 70,
    width: 220,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: AlignmentGeometry.topLeft,
        end: AlignmentGeometry.bottomCenter,
        colors: [Color(0xff9f9f9f), Color(0xff2f004f)],
      ),
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(
          color: Color(0xff5f5f5f),
          blurRadius: anibutton ? 10 : 0,
          offset: Offset(0, anibutton ? 10 : 0),
        ),
      ],
    ),
    child: Text('시작하기 >', style: TextStyle(color: Colors.white, fontSize: 20)),
  ),
);

Widget cloud(BuildContext context) => SizedBox(
  height: 150,
  child: Stack(
    alignment: AlignmentGeometry.center,
    children: [
      posi(0, 150, false),
      posi(10, -40, true),
      posi(40, 200, false),
      posi(60, -40, true),
      posi(80, 120, false),
      before(context),
      line(),
      Positioned(
        top: 0,
        child: SizedBox(
          child: Controller.currentindex != 6
              ? SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: 220,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topLeft,
                        end: AlignmentGeometry.bottomCenter,
                        colors: [Color(0xff9f9f9f), Color(0xff2f004f)],
                      ),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff5f5f5f),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      '시작하기 >',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
        ),
      ),
    ],
  ),
);

Widget before(BuildContext context) => IgnorePointer(
  ignoring: Controller.currentindex == 0 || Controller.currentindex == 6
      ? true
      : false,
  child: Row(
    spacing: 16,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Opacity(
            opacity:
                Controller.currentindex == 0 || Controller.currentindex == 6
                ? 0
                : 0.1,
            child: GestureDetector(
              onTap: () {
                Controller.current.value -= 1;
              },
              child: Container(
                width: 100,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Text(
              '<이전',
              style: TextStyle(
                color:
                    Controller.currentindex == 0 || Controller.currentindex == 6
                    ? Colors.transparent
                    : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Opacity(
            opacity: 0.1,
            child: Controller.currentindex != 5
                ? null
                : GestureDetector(
                    onTap: () {
                      Controller.focusDay = DateTime(
                        Controller.focusDay.year,
                        Controller.focusDay.month,
                        Controller.focusDay.day,
                      );
                      Controller.current.value += 1;
                    },
                    child: Container(
                      width: 150,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Text(
              Controller.currentindex != 5 ? '' : '잘 모르겠어요 >',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget line() => Positioned(
  bottom: 0,
  left: 0,
  right: 0,
  child: Container(
    color: Controller.currentindex == 0 || Controller.currentindex == 6
        ? Colors.transparent
        : Colors.grey,
    height: 6,
    child: Row(
      children: List.generate(5, (index) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color:
                  index + 1 <= Controller.currentindex &&
                      Controller.currentindex != 6
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
      }),
    ),
  ),
);

Widget posi(double top, double left, bool re) => Positioned(
  top: top,
  left: left,
  child: Transform.scale(
    scaleX: re ? -1 : 1,
    child: Image.asset('assets/image/cloud.png', height: 150),
  ),
);

Widget logo(String st) => Column(
  children: [
    // SizedBox(height: 20),
    Image.asset('assets/image/Daily Tarot.png', height: 60),
    Image.asset('assets/image/graphic.png', height: 60),
    Text(
      st,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
);
