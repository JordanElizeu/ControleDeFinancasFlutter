import 'package:app_financeiro/data/repository/firebase/repository_informationofuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InitialController extends GetxController {

  IconData _iconData = Icons.visibility_off;
  bool _moneyVisible = true;
  static String moneyValue = '';
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-BR');

  IconData get iconData => _iconData;

  String? moneyValueFormatted(){
    if(moneyValue.length > 0) {
      return formatter.format(double.parse(moneyValue));
    }
    return null;
  }

  Future<String> getMoneyInFirebase() async {
    await RepositoryTransactions().repositoryGetQuantityMoney().then((value) => {
      moneyValue = value['money'].toString(),
    });
    return formatter.format(double.parse(moneyValue));
  }

  String formatMoney(dynamic value) {
    return formatter.format(value);
  }

  Future<String?> getUserName() async {
    if (FirebaseAuth.instance.currentUser!.displayName != null) {
      return FirebaseAuth.instance.currentUser!.displayName;
    }
    return await getNameIfUserIsFromFirebase();
  }

  Future<String> getNameIfUserIsFromFirebase() {
    return RepositoryInformationOfUser().repositoryGetNameIfUserIsFromFirebase();
  }

  void changeIconDataEyeOfMoney() {
    switch (_moneyVisible) {
      case true:
        _iconData = Icons.visibility_off;
        _moneyVisible = false;
        break;
      case false:
        _iconData = Icons.visibility;
        _moneyVisible = true;
        break;
    }
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get moneyVisible => _moneyVisible;
}
