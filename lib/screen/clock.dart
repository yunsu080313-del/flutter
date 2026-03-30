// import 'dart:math';
// import 'package:flutter/material.dart';
// // 기존에 사용하시던 import 경로를 그대로 유지하세요.
// // import 'package:module_a_101/controller/controller.dart';
//
// class Clock extends StatefulWidget {
//   const Clock({super.key});
//
//   @override
//   State<Clock> createState() => _ClockState();
// }
//
// class _ClockState extends State<Clock> {
//   // 시계판의 정확한 위치를 파악하기 위한 Key
//   final GlobalKey _clockKey = GlobalKey();
//
//   // DateTime time = Controller.focusDay; // 기존 코드 유지
//   double angle = 0;
//   int hour = 6;
//   int minute = 0;
//   bool isHour = true;
//   bool isAm = true;
//
//   void update(Offset globalPosition) {
//     // 1. 시계판(Container)의 RenderBox를 가져옴
//     final renderBox = _clockKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return;
//
//     // 2. 시계판 내의 로컬 좌표로 변환
//     final localPosition = renderBox.globalToLocal(globalPosition);
//     final size = renderBox.size;
//     final center = Offset(size.width / 2, size.height / 2);
//
//     // 3. 중심점으로부터의 거리(vector) 계산
//     double dx = localPosition.dx - center.dx;
//     double dy = localPosition.dy - center.dy;
//
//     // [핵심] 중앙 데드존: 중심에서 15픽셀 이내면 각도를 업데이트하지 않음 (튀는 현상 방지)
//     if (sqrt(dx * dx + dy * dy) < 15) return;
//
//     // 4. 각도 계산 (12시 방향을 0도로 설정)
//     double a = atan2(dy, dx) + pi / 2;
//     if (a < 0) a += 2 * pi;
//
//     setState(() {
//       angle = a;
//       if (isHour) {
//         // 360도를 12시간으로 분할
//         int calculatedHour = (a / (2 * pi) * 12).round();
//         hour = calculatedHour == 0 ? 12 : (calculatedHour > 12 ? 1 : calculatedHour);
//       } else {
//         // 360도를 60분으로 분할
//         minute = (a / (2 * pi) * 60).round() % 60;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // --- 디지털 시간 표시 영역 ---
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _timeBox("${hour.toString().padLeft(2, '0')}", isHour, () => setState(() => isHour = true)),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(':', style: TextStyle(color: Colors.white, fontSize: 25)),
//             ),
//             _timeBox("${minute.toString().padLeft(2, '0')}", !isHour, () => setState(() => isHour = false)),
//             const SizedBox(width: 10),
//             _amPmToggle(),
//           ],
//         ),
//
//         const SizedBox(height: 30),
//
//         // --- 아날로그 시계 조작 영역 ---
//         GestureDetector(
//           onPanDown: (d) => update(d.globalPosition),
//           onPanUpdate: (d) => update(d.globalPosition),
//           onPanEnd: (details) {
//             // Controller 업데이트 로직 (기존 코드 유지)
//             int finalHour = isAm ? (hour == 12 ? 0 : hour) : (hour == 12 ? 12 : hour + 12);
//             print("Selected Time: $finalHour:$minute");
//             /* setState(() {
//               Controller.focusDay = DateTime(
//                 Controller.focusDay.year,
//                 Controller.focusDay.month,
//                 Controller.focusDay.day,
//                 finalHour,
//                 minute,
//               );
//             });
//             Controller.current.value++;
//             */
//           },
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               // 5. 시계 원형판 (여기에 Key를 부여하여 좌표 기준점으로 삼음)
//               Container(
//                 key: _clockKey,
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
//                   color: Colors.white.withOpacity(0.05), // 터치 영역 시각화
//                 ),
//               ),
//
//               // 6. 시계 바늘 (중심 100, 100 기준으로 회전)
//               Transform.rotate(
//                 angle: angle,
//                 child: SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       // 바늘 끝 원
//                       Positioned(
//                         top: 5,
//                         child: Container(
//                           height: 35,
//                           width: 35,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 2),
//                             shape: BoxShape.circle,
//                             color: Colors.blueAccent.withOpacity(0.5),
//                           ),
//                         ),
//                       ),
//                       // 바늘 선
//                       Positioned(
//                         top: 40,
//                         child: Container(width: 2, height: 60, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // 중앙 고정 점
//               Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//               ),
//
//               // 7. 숫자 배치 (200x200 중심인 100, 100 기준)
//               ...List.generate(12, (i) {
//                 final double numAngle = (i / 12) * 2 * pi - pi / 2;
//                 const double radius = 80.0;
//                 final x = cos(numAngle) * radius;
//                 final y = sin(numAngle) * radius;
//                 return Positioned(
//                   left: 100 + x - 10,
//                   top: 100 + y - 10,
//                   child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: Center(
//                       child: Text(
//                         "${i == 0 ? 12 : i}",
//                         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // --- UI 컴포넌트 추출 (코드 가독성) ---
//
//   Widget _timeBox(String text, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         alignment: Alignment.center,
//         width: 60,
//         height: 50,
//         decoration: BoxDecoration(
//           border: Border.all(color: isSelected ? Colors.white : Colors.transparent),
//           borderRadius: BorderRadius.circular(15),
//           color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
//         ),
//         child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 25)),
//       ),
//     );
//   }
//
//   Widget _amPmToggle() {
//     return SizedBox(
//       width: 50,
//       height: 55,
//       child: Column(
//         children: [
//           _amPmButton("AM", isAm, () => setState(() => isAm = true), true),
//           _amPmButton("PM", !isAm, () => setState(() => isAm = false), false),
//         ],
//       ),
//     );
//   }
//
//   Widget _amPmButton(String label, bool isSelected, VoidCallback onTap, bool isTop) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(color: isSelected ? Colors.white : Colors.grey),
//             borderRadius: isTop
//                 ? const BorderRadius.vertical(top: Radius.circular(10))
//                 : const BorderRadius.vertical(bottom: Radius.circular(10)),
//             color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
//           ),
//           child: Text(
//             label,
//             style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';

class FastClock extends StatefulWidget {
  const FastClock({super.key});

  @override
  State<FastClock> createState() => _FastClockState();
}

class _FastClockState extends State<FastClock> {
  double angle = 0;
  int hour = 12, minute = 0;
  bool isHour = true, isAm = true;

  // 1. 수학 연산 및 좌표 계산 최소화
  void update(Offset pos) {
    // 시계 크기가 200x200으로 고정이므로 중심은 무조건 (100, 100)
    double dx = pos.dx - 100;
    double dy = pos.dy - 100;

    // [핵심] 중앙 데드존: 중심에서 반경 10px 이내면 무시 (sqrt 생략으로 연산 속도 최적화)
    if (dx * dx + dy * dy < 100) return;

    // 각도 정규화 (모듈러 연산으로 압축)
    double a = (atan2(dy, dx) + pi / 2) % (2 * pi);
    if (a < 0) a += 2 * pi;

    setState(() {
      angle = a;
      if (isHour) {
        hour = (a / pi * 6).round() == 0 ? 12 : (a / pi * 6).round();
      } else {
        minute = (a / pi * 30).round();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 2. 상단 디지털 UI 초간단 구현 (Container 대신 Text 컬러로 활성화 표현)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() => isHour = true),
              child: Text(
                "${hour.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 30,
                  color: isHour ? Colors.blueAccent : Colors.white,
                ),
              ),
            ),
            const Text(
              " : ",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            GestureDetector(
              onTap: () => setState(() => isHour = false),
              child: Text(
                "${minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 30,
                  color: !isHour ? Colors.blueAccent : Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => setState(() => isAm = !isAm),
              child: Text(
                isAm ? "AM" : "PM",
                style: const TextStyle(fontSize: 24, color: Colors.amber),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // 3. 시계판 (GlobalKey 없이 localPosition만으로 해결)
        GestureDetector(
          onPanDown: (d) => update(d.localPosition),
          onPanUpdate: (d) => update(d.localPosition),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 바늘 (시계판과 동일한 200x200 영역 안에서 회전)
                Transform.rotate(
                  angle: angle,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: 4,
                      height: 85,
                      color: Colors.blueAccent,
                      // 끝에 달린 원을 생략하거나 BoxDecoration으로 한 번에 처리해 코드를 줄임
                    ),
                  ),
                ),
                // 정중앙 핀
                const CircleAvatar(radius: 5, backgroundColor: Colors.white),

                // 숫자 배치 (1줄로 압축)
                ...List.generate(12, (i) {
                  double a = (i / 12) * 2 * pi - pi / 2;
                  return Positioned(
                    left: 100 + cos(a) * 80 - 10,
                    top: 100 + sin(a) * 80 - 10,
                    child: Text(
                      "${i == 0 ? 12 : i}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
