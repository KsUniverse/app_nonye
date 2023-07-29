import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class YunxingTupianPage extends GetView<YunxingTupianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('YunxingTupianPage')),
        body: SafeArea(
            child: CustomPaint(
                foregroundPainter: MyPainter(),
                child: RepaintBoundary(
                    child: Image.asset(
                  "assets/灌溉分区图3.jpg",
                  fit: BoxFit.scaleDown,
                )))));
  }
}

class YunxingTupianController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green.withOpacity(0.8);
    Path path = Path()
      ..moveTo(121, 125)
      ..lineTo(148, 104)
      ..lineTo(200, 88)
      ..lineTo(266, 79)
      ..lineTo(331, 82)
      ..lineTo(353, 115)
      ..lineTo(274, 125)
      ..lineTo(210, 142)
      ..lineTo(180, 158)
      ..lineTo(163, 153)
      ..lineTo(156, 135)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      this != oldDelegate;
}
