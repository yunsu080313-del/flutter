import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_a_101/controller/controller.dart';

Widget gender() => Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  // spacing: 20,

  children: [
    Container(height: 200,width: 0,),
    man('assets/icon/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg', false),
    SizedBox(width: 20),
    man('assets/icon/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg', true)
  ],
);

Widget man(String con, bool man) => GestureDetector(
  onTap: () {
    Controller.man = man;
    Controller.current.value += 1;
  },
  child: Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: CupertinoColors.white,
        width: 2
      ),
    ),
    child: SizedBox(width: 50,height: 50, child: SvgPicture.asset(con,width: 50,height: 50,fit: BoxFit.contain,)),
  ),
);