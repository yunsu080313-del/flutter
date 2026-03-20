import 'dart:math';
import 'package:flutter/material.dart';
import 'package:module_a_101/controller/controller.dart';
import 'package:module_a_101/screen/main.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime time = Controller.focusDay;

  double angle = 0;
  int hour = 6;
  int minute = 0;
  bool isHour = true;
  bool isAm = true;

  void update(Offset p, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    double a = atan2(p.dy - c.dy, p.dx - c.dx) - pi / 2;
    if (a < 0) a += 2 * pi;

    setState(() {
      angle = a;
      if (isHour) {
        hour = ((a / (2 * pi) * 12).round() - 6) % 12;
        if (hour == 0) hour = 12;
      } else {
        minute = ((a / (2 * pi) * 60).round() - 30) % 60;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            GestureDetector(
              onTap: () {
                isHour = true;
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isHour ? Colors.white : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "${hour.toString().padLeft(2, '0')}",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Text(':', style: TextStyle(color: Colors.white, fontSize: 25)),
            GestureDetector(
              onTap: () {
                isHour = false;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: !isHour ? Colors.white : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                width: 60,
                height: 50,
                child: Text(
                  "${minute.toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 5),
            Container(
              width: 40,
              height: 50,
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAm = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isAm ? Colors.white : Colors.grey,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          'AM',
                          style: TextStyle(
                            color: isAm ? Colors.white : Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAm = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: !isAm ? Colors.white : Colors.grey,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          'PM',
                          style: TextStyle(
                            color: !isAm ? Colors.white : Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 30),

        GestureDetector(
          onPanEnd: (details) {
            print(Controller.focusDay);
            if (!isHour) {
              int finalHour;

              if (isAm) {
                finalHour = hour == 12 ? 0 : hour;
              } else {
                finalHour = hour == 12 ? 12 : hour + 12;
              }

              setState(() {
                Controller.focusDay = DateTime(
                  Controller.focusDay.year,
                  Controller.focusDay.month,
                  Controller.focusDay.day,
                  finalHour,
                  minute,
                );
              });
              Controller.current.value++;
              setState(() {

              });
            }
            print(Controller.focusDay);
          },
          onPanDown: (d) {
            final b = context.findRenderObject() as RenderBox;
            update(b.globalToLocal(d.globalPosition), b.size);
          },
          onPanUpdate: (d) {
            final b = context.findRenderObject() as RenderBox;
            update(b.globalToLocal(d.globalPosition), b.size);
          },
          child: Stack(
            alignment: Alignment.center,

            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
              ),

              // 바늘 (관통 방지)
              Transform.rotate(
                angle: angle,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 160),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        width: 2,
                        height: 65,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              ...List.generate(12, (i) {
                final angle = (i / 12) * 2 * pi - pi / 2;
                final radius = 80.0;

                final x = cos(angle) * radius;
                final y = sin(angle) * radius;

                final number = i == 0 ? 12 : i;

                return Positioned(
                  left: 200 + x - 10,
                  top: 100 + y - 10,
                  child: Text(
                    "$number",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
