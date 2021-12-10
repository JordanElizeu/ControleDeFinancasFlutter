import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InitialController extends GetxController {
  double _valorTotal = 0;
  IconData _iconData = Icons.remove_red_eye;
  bool _moneyVisible = true;

  bool get moneyVisible => _moneyVisible;

  IconData get getIconData => _iconData;

  String get getFormattedValorTotal {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-BR');
    return formatter.format(_valorTotal);
  }

  set setValorTotal(double value) {
    _valorTotal = value;
  }

  String getUserName() {
    return "Jordan";
  }

  void changeIconDataEye() {
    switch(_moneyVisible){
      case true:
        _iconData = Icons.remove_red_eye_outlined;
        _moneyVisible = false;
        break;
      case false:
        _iconData = Icons.remove_red_eye;
        _moneyVisible = true;
        break;
    }
    update();
  }
}
