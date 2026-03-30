import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_a_101/controller/controller.dart';
import 'package:module_a_101/screen/mysoulcard.dart';
import 'package:module_a_101/utills.dart';
import 'home.dart';

class Soulcard extends StatefulWidget {
  const Soulcard({super.key});

  @override
  State<Soulcard> createState() => _SoulcardState();
}

class _SoulcardState extends State<Soulcard> {
  final yController = FixedExtentScrollController(initialItem: 126);
  final mController = FixedExtentScrollController();
  final dController = FixedExtentScrollController();

  bool isSelect = false;

  DateTime birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.centerStart,
            end: AlignmentGeometry.bottomCenter,
            colors: [Color(0xff3f005f), Color(0xff2f003f)],
          ),
        ),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Transform.rotate(angle: pi, child: cloud(context)),
            ),
            Positioned(bottom: 0, right: 0, left: 0, child: cloud(context)),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                        height: 40,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/image/graphic.png',
                    width: 100,
                    height: 80,
                  ),
                  Text(
                    '나의 생일로 알아보는 소울카드',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      // text: '소울 넘버',
                      style: TextStyle(fontSize: 14, height: 2),

                      children: <TextSpan>[
                        TextSpan(
                          text: '소울 넘버',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        TextSpan(
                          text:
                              '는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로카드가 바로 ',
                        ),
                        TextSpan(
                          text: '소울 카드',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        TextSpan(
                          text:
                              '이며, \n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상집합니다.\n즉, 소울 넘버는 당신의 ',
                        ),
                        TextSpan(
                          text: '영혼의 번호',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        TextSpan(text: '이고,\n소울 카드는 그 번호가 의미하는\n'),
                        TextSpan(
                          text: '영혼의 본질',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        TextSpan(text: '을 보여주는 상징인 셈입니다.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => birth(),
                      );
                    },
                    child: Container(
                      width: 210,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isSelect
                                ? format('yyyy년M월d일', birthday)
                                : '생년월일을 입력해주세요',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Transform.rotate(
                            angle: pi,
                            child: isSelect
                                ? SizedBox()
                                : SvgPicture.asset(
                                    'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                                    height: 25,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async {
                      // Navigator.pop(context);
                      if (Controller.Moon.value >= 10)  {
                        Controller.Moon.value -= 10;
                        await Controller.saveMoon();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mysoulcard(Date: birthday),
                          ),
                        );
                      } else {
                        SnackBar(content: Text('달이 부족해용'));
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff5f5f5f),
                            blurRadius: 10,
                            offset: Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topLeft,
                          end: AlignmentGeometry.bottomCenter,
                          colors: [Color(0xff6f6f6f), Color(0xff3f006f)],
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/moon.png', height: 40),
                          Text(
                            '달 10개로 소울카드 찾기',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    '소울카드에 사용되는 정보는\n 카드 조합 용도 외에 사용되지 않습니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget birth() => Dialog(
    child: Container(
      width: 500,
      height: 290,
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      // color: Color(0xff3f004f),
      decoration: BoxDecoration(
        color: Color(0xff3f004f),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '생년월일 선택',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 2.5,
            ),
          ),
          Container(width: 500, height: 1, color: Colors.grey),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 150,
            child: Row(children: [ypicker(), mpicker(), dpicker()]),
          ),
          SizedBox(height: 10),
          Container(width: 500, height: 1, color: Colors.grey),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20,
            children: [
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '취소',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print(yController.selectedItem + 1900);
                  print(mController.selectedItem % 12 + 1);
                  print(dController.selectedItem % 31 + 1);
                  DateTime(
                    yController.selectedItem + 1900,
                    mController.selectedItem % 12 + 1,
                    dController.selectedItem % 31 + 2,
                  );
                  if (DateTime(
                    yController.selectedItem + 1900,
                    mController.selectedItem % 12 + 1,
                    dController.selectedItem % 31 + 2,
                  ).isBefore(DateTime.now())) {
                    birthday = DateTime(
                      yController.selectedItem + 1900,
                      mController.selectedItem % 12 + 1,
                      dController.selectedItem % 31 + 1,
                    );
                    setState(() {
                      isSelect = true;
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  '선택',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget ypicker() => basePicker(
    yController,
    ListWheelChildListDelegate(
      children: List.generate(
        127,
        (index) => Center(
          child: Text(
            (index + 1900).toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    ),
  );

  Widget mpicker() => basePicker(
    mController,
    ListWheelChildLoopingListDelegate(
      children: List.generate(
        12,
        (index) => Center(
          child: Text(
            (index + 1).toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 20, fontWeight: .w400),
          ),
        ),
      ),
    ),
  );

  Widget dpicker() => basePicker(
    dController,
    ListWheelChildLoopingListDelegate(
      children: List.generate(
        31,
        (index) => Center(
          child: Text(
            (index + 1).toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 20, fontWeight: .w400),
          ),
        ),
      ),
    ),
  );

  Widget basePicker(
    FixedExtentScrollController controller,
    ListWheelChildDelegate child,
  ) => Expanded(
    child: DefaultTextStyle(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      child: Stack(
        children: [
          ListWheelScrollView.useDelegate(
            diameterRatio: 1000000000,
            magnification: 1.1,
            useMagnifier: true,
            physics: FixedExtentScrollPhysics(),
            itemExtent: 55,
            onSelectedItemChanged: (value) {
              final year = value + 1900;
              print(controller.selectedItem);
            },
            childDelegate: child,
            controller: controller,
          ),
          overlay(),
        ],
      ),
    ),
  );

  Widget overlay() => IgnorePointer(
    ignoring: true,
    child: Column(
      children: [
        Container(
          height: 50,
          color: Color(0xff3f004f),
          child: Opacity(opacity: 0.5),
        ),
        Container(
          height: 50,
          width: 15,
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.white, width: 1),
            ),
          ),
        ),
        Container(height: 50),
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
