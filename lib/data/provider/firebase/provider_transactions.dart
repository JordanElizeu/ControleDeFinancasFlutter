import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/withdraw_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ProviderTransactions {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool?> addDeposit(
      {required double quantityMoney,
      required String title,
      required BuildContext context,
      required String description}) async {
    try {
      double availableMoney = double.parse(await getAvailableMoney());
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('Finances')
          .child('money')
          .set(quantityMoney + availableMoney);
      _addTransaction(
          quantityMoney: quantityMoney,
          title: title,
          description: description,
          isDeposit: true);
      return true;
    } catch (exception) {
      alertDialogViewFailure(
          titleError: 'Erro inesperado',
          context: context,
          messageError: 'Ocorreu um erro inesperado');
    }
  }

  void _addTransaction(
      {required double quantityMoney,
      required String title,
      required String description,
      required bool isDeposit}) {
    var uuid = Uuid().v4();
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(uuid)
        .child('money')
        .set(quantityMoney);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(uuid)
        .child('title')
        .set(title);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(uuid)
        .child('description')
        .set(description);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(uuid)
        .child('uid')
        .set(uuid);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(uuid)
        .child('is_deposit')
        .set(isDeposit);
  }

  Future<bool?> moneyWithdraw(
      {required double moneyWithdraw,
      required BuildContext context,
      required String description,
      required String title}) async {
    double availableMoney = double.parse(await getAvailableMoney());
    if (moneyWithdraw > availableMoney) {
      alertDialogViewFailure(
          titleError: 'Saldo insuficiente',
          context: context,
          messageError: 'Saldo em conta insufiente para efetuar transação');
    } else {
      try {
        _databaseReference
            .child('AppFinancas')
            .child(_auth.currentUser!.uid)
            .child('Account')
            .child('Finances')
            .child('money')
            .set(availableMoney - moneyWithdraw);
        _addTransaction(
            isDeposit: false,
            quantityMoney: moneyWithdraw,
            title: title,
            description: description);
        WithdrawMoneyController().clearFields();
        Controller().pageTransition(route: Routes.HOME, context: context);
        return true;
      } catch (exception) {
        alertDialogViewFailure(
            titleError: 'Erro inesperado',
            context: context,
            messageError: 'Ocorreu um erro inesperado');
      }
    }
  }

  Future<String> getAvailableMoney() async {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${_auth.currentUser!.uid}/Account/Finances');
    DatabaseEvent event = await _databaseReference.once();
    return event.snapshot.child('money').value.toString();
  }

  Future<Map<dynamic, dynamic>> getAllTransactions() async {
    DatabaseReference _databaseReference = FirebaseDatabase.instance.ref(
        'AppFinancas/${_auth.currentUser!.uid}/Account/Finances/transactions');
    DatabaseEvent event = await _databaseReference.once();
    return event.snapshot.value as Map;
  }
}
