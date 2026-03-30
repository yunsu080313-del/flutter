import 'dart:math';

import 'package:flutter/material.dart';

import '../controller/controller.dart';
import 'home.dart';

class Checktarot extends StatefulWidget {
  const Checktarot({super.key, required this.TarotNum, required this.IsFruit});

  final int TarotNum;
  final bool IsFruit;

  @override
  State<Checktarot> createState() => _ChecktarotState();
}

class _ChecktarotState extends State<Checktarot> {
  dynamic TarotData;
  bool check = false;

  @override
  void initState() {
    super.initState();
    _load();
    print(TarotData);
  }

  Future<void> _load() async {
    final data = await Controller.loadJson(
      widget.IsFruit ? 'assets/fruit_tarot_cards_data.json' : 'assets/loves_tarot_cards_data.json',
      widget.TarotNum,
    );
    setState(() {
      TarotData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          alignment: AlignmentGeometry.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Transform.rotate(angle: pi, child: cloud(context)),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: cloud(context)),
            Column(
              children: [
                SizedBox(height: 40),
                Image.asset('assets/image/graphic.png', height: 70),
                Text(
                  '아래의 타로카드를 선택하셨군요\n결과를 확인해보세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  height: 150,
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              top: check ? 200 : 250,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    height: check ? 150 : 200,
                    width: check ? 100 : 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/image/tarot_cards/${TarotData['image']}',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${TarotData['number']}. ${TarotData['name']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 410,
              child: AnimatedOpacity(
                opacity: check ? 1 : 0,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: 300,
                  child: Text(
                    '${TarotData['storytelling'].replaceAll('.', '.\n\n')}',
                    softWrap: true,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: check ? 1 : 0,
                child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                  child: Container(
                    alignment: AlignmentGeometry.center,
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('돌아가기'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              child: GestureDetector(
                onTap: () {
                  check = true;
                  setState(() {});
                },
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: check ? 0 : 1,
                  child: Container(
                    height: 60,
                    width: 150,
                    alignment: AlignmentGeometry.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topLeft,
                        end: AlignmentGeometry.bottomCenter,
                        colors: [Color(0xff5f5f5f), Color(0xff3f004f)],
                      ),
                    ),
                    child: Text('결과 확인', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
