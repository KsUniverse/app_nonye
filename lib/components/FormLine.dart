import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormLine extends GetView {
  final String label;
  final Widget child;
  final TextStyle? labelStyle;
  final int? labelFlex;

  const FormLine(
      {Key? key,
      required this.label,
      required this.child,
      this.labelStyle,
      this.labelFlex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            height: 56,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            ),
            padding: const EdgeInsets.only(bottom: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: labelFlex ?? 2,
                      child: Text(
                        "$label: ",
                        textAlign: TextAlign.start,
                        style: labelStyle,
                      )),
                  Expanded(flex: 4, child: child)
                ])));
  }
}
