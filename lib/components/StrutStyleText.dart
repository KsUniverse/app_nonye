import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrutStyleText extends GetView {
  final String text;

  const StrutStyleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 22,
        leadingDistribution: TextLeadingDistribution.even,
      ),
    );
  }
}
