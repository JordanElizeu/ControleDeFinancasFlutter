import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InitialController extends GetxController {
  IconData _iconData = Icons.visibility_off;
  bool _moneyVisible = true;

  bool get moneyVisible => _moneyVisible;

  IconData get getIconData => _iconData;

  Future<String> getMoneyInFirebase() async{
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-BR');
    return formatter.format(double.parse(await RepositoryTransactions().getQuantityMoney()));
  }

  String? getUserName() {
    return FirebaseAuth.instance.currentUser!.displayName;
  }

  void changeIconDataEyeOfMoney() {
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
