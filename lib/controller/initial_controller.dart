import 'package:app_financeiro/data/repository/firebase/repository_firebaselogin.dart';
import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InitialController extends GetxController {

  IconData _iconData = Icons.visibility_off;
  bool _moneyVisible = true;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-BR');

  bool get moneyVisible => _moneyVisible;

  IconData get getIconData => _iconData;

  Future<String> getMoneyInFirebase() async {
    Map value = await RepositoryTransactions().repositoryGetQuantityMoney();
    return formatter.format(double.parse(value['money'].toString()));
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
    return RepositoryFirebaseLogin().repositoryGetNameIfUserIsFromFirebase();
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
}
