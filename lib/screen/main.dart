import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_a_101/screen/fruitTarot.dart';
import 'package:module_a_101/screen/home.dart';
import 'package:module_a_101/screen/lovetarot.dart';
import 'package:module_a_101/screen/moon.dart';
import 'package:module_a_101/screen/soulcard.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final tarotlist = [
    [
      '인연 타로',
      '지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?',
      'assets/image/love_tarot.png',
    ],
    ['열매 타로', '지금 생각하고 있는 일은\n어떤 결과로 이어질까?', 'assets/image/fruit_tarot.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Controller.Moon,
      builder: (context, value, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        SizedBox(height: 20),
                        moon(),

                        Align(alignment: AlignmentGeometry.center, child: logo('')),

                        soulcard(),
                        SizedBox(height: 20),
                        Daily_Tarot_List(),
                        SizedBox(height: 20),
                        Daily_Master(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget Daily_Master() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Daily Master', style: TextStyle(fontSize: 24)),
      SizedBox(height: 10),
      GestureDetector(
        onTap: () async {
          final url = Uri.parse('https://ko.wikipedia.org/wiki/타로');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/daily_master.png'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Color(0xff4f005f),
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '당신만을 위한 상담',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                '당신을 위해 모인 \'데일리마스터\'와\n직접 이야기를 나누어 보세요.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget Daily_Tarot_List() => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Daily Tarot List',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      SizedBox(
        height: 220,
        width: double.infinity,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(width: 20);
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => TarotList(
            tarotlist[index][0],
            tarotlist[index][1],
            tarotlist[index][2],
          ),
          itemCount: 2,
        ),
      ),
    ],
  );


  Widget TarotList(String tarot, String ex, String pic) => GestureDetector(
    onTap: () {
      // showToast();
      if (tarot == '인연 타로') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Lovetarot()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FruitTarot()),
        );
      }
    },
    child: Container(
      width: 200,
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(pic), fit: BoxFit.fill),
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tarot,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            ex,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );

  Widget soulcard() => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Daily Tarot Soul Card',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
      SizedBox(height: 10),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Soulcard()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage('assets/image/daily_tarot_soul_card.png'),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff4f1f5f),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Soul Card',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                '운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.',
                style: TextStyle(color: Colors.white, fontSize: 13),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget moon() => GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Moon()));
    },
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(width: 10),
        ],
      ),
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

void showToast(String msg) => Fluttertoast.showToast(
  msg: msg,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.white10,
  fontSize: 20,
  toastLength: Toast.LENGTH_SHORT,
);