import 'package:app_financeiro/data/provider/firebase/provider_transactions.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ProviderWithdraw extends ProviderTransactions {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> providerMoneyWithdraw(
      {required double moneyWithdraw,
      required BuildContext context,
      required String description,
      required String title}) async {
    Map mapValueMoney = await getAvailableMoney(auth: _auth);
    double availableMoney = double.parse(mapValueMoney['money'].toString());
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
        await addTransaction(
            isDeposit: false,
            quantityMoney: moneyWithdraw,
            title: title,
            description: description,
            databaseReference: _databaseReference,
            auth: _auth);
      } catch (exception) {
        alertDialogViewFailure(
            titleError: 'Erro inesperado',
            context: context,
            messageError: 'Ocorreu um erro inesperado');
      }
    }
  }
}
