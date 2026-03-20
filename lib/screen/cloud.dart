import 'dart:math' as math;

import 'package:flutter/material.dart';

class cloud extends StatefulWidget {
  const cloud({super.key});

  @override
  State<cloud> createState() => _cloudState();
}

class _cloudState extends State<cloud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: SizedBox(child: pic(true))),
    );
  }

  Widget pic(bool cp) => Image.asset(cp  ? 'assets/image/cloud.png' : 'assets/image/cloud1.png');
}
