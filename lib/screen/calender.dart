import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_a_101/controller/controller.dart';
import 'package:module_a_101/utills.dart';

Widget calender(BuildContext context) {

  return Column(children: [title(context),month(DateTime(Controller.focusDay.year,Controller.focusDay.month))]);
}

Widget month(DateTime date) {
  final firstOffset = DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  final dayInMonth = DateUtils.getDaysInMonth(date.year, date.month);

  final endOffset =
      7 -
      DateUtils.firstDayOffset(
        date.year,
        date.month + 1,
        DefaultMaterialLocalizations(),
      );

  final weekInMonth = ((dayInMonth + endOffset) / 7).ceil();

  return Container(
    width: 300,
    height: 50.0 * weekInMonth,
    child: Wrap(
      children: [
        ...List.generate(
          firstOffset,
          (index) =>
              cell(date.subtract(Duration(days: firstOffset - index)), false),
        ),
        ...List.generate(
          dayInMonth,
          (index) => cell(DateUtils.addDaysToDate(date, index), true),
        ),
        ...List.generate(
          endOffset,
          (index) => cell(
            DateUtils.addDaysToDate(DateTime(date.year, date.month + 1), index),
            false,
          ),
        ),
      ],
    ),
  );
}

Widget cell(DateTime date, bool thisweek) => GestureDetector(
  onTap: () {
    Controller.focusDay = date;
    Controller.current.value += 1;
  },

  child: Opacity(
    opacity: thisweek ? 1 : 0.3,
    child: SizedBox(
      height: 50,
      width: 300 / 7,
      child: Text(date.day.toString(), style: TextStyle(color: Colors.white)),
    ),
  ),
);

Widget title(BuildContext context) {
  final now = DateTime.now();

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            color: Color(0xff2f004f),
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {
                  Controller.focusDay = value;

                },
                mode: CupertinoDatePickerMode.monthYear,
                minimumYear: 1900,
                maximumYear: now.year,
                initialDateTime: Controller.focusDay,
              ),
            ),
          );
        },
      );
    },
    child: Text(
      format('yyyy .M', Controller.focusDay),
      style: TextStyle(color: Colors.white, fontSize: 30),
    ),
  );
}
