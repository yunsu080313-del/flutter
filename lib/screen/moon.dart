import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module_a_101/screen/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_a_101/screen/main.dart';

import '../controller/controller.dart';
import '../utills.dart';

class Moon extends StatefulWidget {
  const Moon({super.key});

  @override
  State<Moon> createState() => _MoonState();
}

class _MoonState extends State<Moon> {
  @override
  Widget build(BuildContext context) {
    final dmoon = [25, 50, 75, 100, 200, 350];
    final much = [5500, 9900, 14000, 17000, 33000, 55000];

    return ValueListenableBuilder(
      valueListenable: Controller.Moon,
      builder: (context, value, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: 1100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff3f005f), Color(0xff2f003f)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Transform.rotate(angle: pi, child: cloud(context)),
                ),
                Positioned(bottom: 0, left: 0, right: 0, child: cloud(context)),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, Controller.Moon);
                            setState(() {});
                          },
                          child: SvgPicture.asset(
                            'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Image.asset('assets/image/graphic.png', width: 70),
                      Text('달 충전', style: TextStyle(fontSize: 22)),
                      SizedBox(height: 10),
                      Text('현재 보유중인 달', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            child: Image.asset('assets/image/moon.png'),
                          ),
                          Text(
                            '${Controller.Moon.value}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 10),
                      ...List.generate(
                        6,
                            (index) => charge(index, dmoon[index], much[index]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget charge(int i, int moonc, int much) {
    int des = moonc * 250 - much;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        showToast('${moonc}개 충전 됐습니다.');
        Controller.Moon.value += moonc;
        await Controller.saveMoon();
        setState(() {});
      },
      child: Column(
        children: [
          Row(
            children: [
              moon(i),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('달 $moonc개', style: TextStyle(fontSize: 20)),
                  Text(
                    '약 ${formatter.format(des)}원 할인',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Text(
                '${formatter.format(much)}원',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Container(
            height: i == 5 ? 0 : 1,
            width: 370,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  Widget moon(int i) => SizedBox(
    height: 60,
    width: 60,
    child: Stack(
      children: [
        Positioned(
          right: 0,
          bottom: 5,
          child: i < 4
              ? SizedBox.shrink()
              : Image.asset('assets/image/moon.png'),
          width: 20,
          height: 20,
        ),
        Positioned(
          right: 0,
          child: i < 2
              ? SizedBox.shrink()
              : Image.asset('assets/image/moon.png'),
          width: 40,
          height: 40,
        ),
        Positioned(
          child: Image.asset('assets/image/moon.png'),
          width: 60,
          height: 60,
        ),
      ],
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
      ],
    ),
  );
}
