import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransitionPage{
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
