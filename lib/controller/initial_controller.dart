import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InitialController extends GetxController {
  static double _valorTotal = 0;
  IconData _iconData = Icons.visibility_off;
  bool _moneyVisible = true;

  bool get moneyVisible => _moneyVisible;

  IconData get getIconData => _iconData;

  double get valorTotal => _valorTotal;

  String get getFormattedValorTotal {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-BR');
    return formatter.format(_valorTotal);
  }

  set setValorTotal(double value) {
    _valorTotal += value;
    update();
  }

  String getUserName() {
    return "Jordan";
  }

  void changeIconDataEye() {
    switch(_moneyVisible){
      case true:
        _iconData = Icons.visibility;
        _moneyVisible = false;
        break;
      case false:
        _iconData = Icons.visibility_off;
        _moneyVisible = true;
        break;
    }
    update();
  }
}
