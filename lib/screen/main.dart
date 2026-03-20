import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_a_101/screen/home.dart';

import '../controller/controller.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff3f004f), Color(0xff2f003f)],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  SizedBox(height: 20),
                  moon(),

                  Align(alignment: AlignmentGeometry.center, child: logo('')),
                  Text(
                    'Darily Tarot Soul Card',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage('assets/image/daily_tarot_soul_card.png')),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff4f1f5f),
                          blurRadius: 10,
                          spreadRadius: 5
                        ),
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Soul Card',style: TextStyle(color: Colors.white,fontSize: 24),),
                        Text('운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.',style: TextStyle(color: Colors.white,fontSize: 13),textAlign: TextAlign.end)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moon() => Align(
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/image/moon.png'),
        ),
        Text(
          Controller.Moon.toString(),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(width: 10),
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
