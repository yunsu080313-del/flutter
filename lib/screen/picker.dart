import 'package:flutter/material.dart';

class picker extends StatefulWidget {
  const picker({super.key});

  @override
  State<picker> createState() => _pickerState();
}

class _pickerState extends State<picker> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
        decoration: BoxDecoration(
          color: Color(0xff2f004f),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '생년월일 선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(width: double.infinity,height:1,color: Colors.grey),
            Picker(),
            Container(width: double.infinity,height:1,color: Colors.grey),
          ],
        ),
      ),
    );
  }
  Widget Picker() => Container(
  );
}
