import 'dart:math';
import 'package:flutter/material.dart';
import 'package:module_a_101/screen/checktarot.dart';

import 'home.dart';

class Lovetarot extends StatefulWidget {
  const Lovetarot({super.key});

  @override
  State<Lovetarot> createState() => _LovetarotState();
}

class _LovetarotState extends State<Lovetarot> {
  // ⭐ 0.08로 설정하여 카드들이 아주 촘촘하게 겹치도록 유지합니다.
  final PageController _controller = PageController(
    initialPage: 1000,
    viewportFraction: 0.08,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff3f005f), Color(0xff2f003f)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// 상단 구름 (기존 유지)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Transform.rotate(angle: pi, child: cloud(context)),
            ),

            /// 텍스트 영역 (기존 유지)
            Column(
              children: const [
                SizedBox(height: 60),
                Image(
                  image: AssetImage('assets/image/graphic.png'),
                  height: 80,
                ),
                Text(
                  '인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '생각하고 있는 그 사람과 인연이 될 수 있을까요?',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 180),
                Text(
                  '좌우로 스크롤하여\n카드 한 장을 골라보세요!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            /// 카드 영역 (높이 변화 최소화 + 크기 고정)
            Positioned(
              bottom: -110,
              // 화면 하단에 더 밀착
              height: 450,
              left: 0,
              right: 0,
              child: PageView.builder(
                controller: _controller,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      double value = 0;
                      if (_controller.hasClients &&
                          _controller.position.haveDimensions) {
                        value = _controller.page! - index;
                      } else {
                        value = (1000 - index).toDouble();
                      }

                      // 1. 회전 각도: 높이 변화가 적으므로 회전도 살짝만 (0.15 -> 0.1)
                      double angle = value * -0.1;

                      // 2. ⭐ Y축 위치 (높이 변화 최소화): 계수를 12에서 4로 대폭 낮춤
                      // 제곱값을 사용해 중앙은 평평하고 끝에서만 살짝 처지게 설정
                      double ty = (value.abs() * value.abs() * 3);

                      // 3. 크기 고정: 변화 없음
                      double scale = 1.0;

                      return Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(0.0, ty)
                          ..rotateZ(angle)
                          ..scale(scale),
                        child: child,
                      );
                    },
                    child: Center(
                      child: OverflowBox(
                        maxWidth: 130 * 1.5,
                        maxHeight: 230 * 1.5,
                        child: Listener(
                          behavior: HitTestBehavior.translucent,
                          onPointerDown: (event) {
                            print('didhd');
                          },
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Checktarot(TarotNum: Random().nextInt(8)+1, IsFruit: false)));
                            },
                            child: SizedBox(
                              width: 180,
                              height: 300,
                              child: Image.asset(
                                'assets/image/tarot_card_back.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 기존 함수 보존 ---
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
  // Widget posi(double top, double left, bool flip) => Container();
  // Widget before(BuildContext context) => Container();
  // Widget line() => Container();
}
