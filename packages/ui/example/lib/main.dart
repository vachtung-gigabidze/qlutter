library;

import 'package:flutter/material.dart';

import 'package:ui/ui.dart';

void main() {
  runApp(
    MaterialApp(
      home: ColoredBox(
        color: Color(0xffF8F4FF),
        child: Center(
          child: SizedBox(height: 600, width: 600, child: const PlayGround()),
        ),
      ),
    ),
  );
}
