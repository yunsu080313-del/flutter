import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module_a_101/screen/checktarot.dart';

import 'home.dart';

class FruitTarot extends StatefulWidget {
  const FruitTarot({super.key});

  @override
  State<FruitTarot> createState() => _FruitTarotState();
}

class _FruitTarotState extends State<FruitTarot> {
  Timer? _timer;
  int _counter = -1;

  void startTimer() {
    _timer?.cancel();
    _counter = -1;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (!mounted) return;

      print(_counter);
      setState(() {
        _counter++;
        if (_counter == 5) {
          _counter++;
        }
      });
      if (_counter >= 9) {
        print(_counter);
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool cardani = false;

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
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('assets/image/graphic.png', width: 70),
                Text(
                  '열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 10),
                Text(
                  '지금 생각하고 있는 일은 어떤 결과로 이어질까요?',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 40),
                Container(
                  height: 450,
                  width: 300,

                  // color: Colors.white,
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [...List.generate(9, (index) => where(index))],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cardani = false;
                    });
                    startTimer();
                    setState(() {
                      cardani = true;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('셔플', style: TextStyle(fontSize: 18)),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget where(int index) => AnimatedPositioned(
    duration: Duration(milliseconds: 500),
    top: _counter <= index && cardani ? 150 : (index / 3).toInt() * 150,
    left: _counter <= index && cardani ? 110 : index % 3 * 100 + 10,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Checktarot(TarotNum: Random().nextInt(8)+1, IsFruit: true)));
      },
      child: Container(
        width: 90,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/tarot_card_back.png'),
            fit: BoxFit.fill,
          ),
        ),
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
