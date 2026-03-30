import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module_a_101/controller/controller.dart';
import 'package:module_a_101/utills.dart';

class Mysoulcard extends StatefulWidget {
  const Mysoulcard({super.key, required this.Date});

  final DateTime Date;

  @override
  State<Mysoulcard> createState() => _MysoulcardState();
}

int soulnumber(DateTime date) {
  String count = '';
  count = (date.year + date.month + date.day).toInt().toString();
  int c = 0;
  while (count.length > 1) {
    c = 0;
    for (int i = 0; i < count.length; i++) {
      c += int.parse(count[i]);
    }
    count = c.toString();
  }
  return c;
}

class _MysoulcardState extends State<Mysoulcard>
    with SingleTickerProviderStateMixin {
  dynamic data;

  late AnimationController controller;
  bool small = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 2000));
      controller.forward(from: 0);
      setState(() {
        small = true;
      });
    });
  }

  Future<void> _loadData() async {
    final result = await Controller.loadJson('assets/soul_cards_data.json',soulnumber(widget.Date));

    setState(() {
      data = result;
    });
  }

  // final data = Controller.loadJson(9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          print(soulnumber(widget.Date));

          print('assets/image/tarot_cards/${data['image']}');
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    height: 220,
                    child: Column(
                      children: [
                        AnimatedAlign(
                          alignment: AlignmentGeometry.center,
                          duration: Duration(milliseconds: 1000),
                          child: Image.asset(
                            'assets/image/graphic.png',
                            width: 70,
                          ),
                        ),
                        Text(
                          '${data['number']}번 ${data['name']}',
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: small ? 1 : 0,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 150),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/image/graphic.png',
                                height: 70,
                              ),
                              Text(format('yyyy월 M월 d일생,\n', widget.Date),style: TextStyle(fontSize: 16),),
                              Container(child: Text('당신의 소울카드는\n${data['number']}번 ${data['name']} 입니다.',style: TextStyle(fontSize: 16),textAlign: TextAlign.left,))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                      SizedBox(width: 350, child: Text('${data['storytelling']}',textAlign: TextAlign.center,style: TextStyle(fontSize: 19),softWrap: true,)),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)
                          ),
                          child: Icon(Icons.clear,color: Colors.grey,),
                        ),
                      ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 1000),
                top: small ? 50 : null,
                left: small ? 35 : null,
                child: AnimatedBuilder(
                  animation: controller,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    width: small ? 115 : 230,
                    height: small ? 175 : 350,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/image/tarot_cards/${data['image']}',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  builder: (context, child) {
                    final angle = controller.value * 3 * pi;

                    return Transform(
                      alignment: AlignmentGeometry.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(angle),
                      child: child,
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
