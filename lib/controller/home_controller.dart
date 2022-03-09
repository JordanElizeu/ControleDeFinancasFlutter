import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:app_financeiro/data/repository/firebase/repository_informationofuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  IconData _iconData = Icons.visibility_off;
  bool _moneyVisible = true;
  static String? moneyValue;
  final NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-BR');
  IconData get iconData => _iconData;
  bool get moneyVisible => _moneyVisible;

  final RepositoryTransactions _repositoryTransactions =
      getIt.get<RepositoryTransactions>();
  final RepositoryInformationOfUser _repositoryInformationOfUser =
      getIt.get<RepositoryInformationOfUser>();
  final RepositoryConnection _repositoryConnection =
      getIt.get<RepositoryConnection>();

  String? moneyValueFormatted({required String? value}) {
    if (value != null) {
      return formatter.format(double.parse(moneyValue!));
    }
    return null;
  }

  Future<String> getMoneyInFirebase() async {
    await _repositoryTransactions.repositoryGetQuantityMoney().then((value) => {
          if (value!['money'] != null)
            {moneyValue = value['money'].toString()}
          else
            {moneyValue = '0'}
        });
    return formatter.format(double.parse(moneyValue!));
  }

  String formatMoney(dynamic value) {
    return formatter.format(value);
  }

  Future<String?> getUserName() async {
    if (_repositoryConnection
            .connectionFirebaseAuth()
            .currentUser
            ?.displayName !=
        null) {
      return FirebaseAuth.instance.currentUser!.displayName;
    }
    return await _repositoryInformationOfUser
        .repositoryGetNameIfUserIsFromFirebase();
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
