import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransitionController extends GetxController {
  Future<bool> finishAndPageTransition(
      {required String route, required BuildContext context}) async {
    try {
      await Navigator.of(context).popAndPushNamed(route);
      return true;
    } catch (e) {
      return false;
    }
  }
}
