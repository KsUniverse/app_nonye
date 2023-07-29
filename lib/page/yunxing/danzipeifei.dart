import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DanzipeifeiPage extends GetView<DanzipeifeiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('DanzipeifeiPage')),
        body: SafeArea(child: Text('DanzipeifeiController')));
  }
}

class DanzipeifeiController extends GetxController {}
