import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ProviderTransactions {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void addDeposit({required double quantityMoney}) {
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('money')
        .set(quantityMoney);
  }

  void moneyWithdraw(
      {required double moneyWithdraw, required BuildContext context}) async {
    double moneyAvailable = double.parse(await getMoneyValue());
    if (moneyWithdraw > moneyAvailable) {
      alertDialogViewFailure(
          titleError: 'Saldo insuficiente',
          context: context,
          messageError: 'Saldo em conta insufiente para efetuar transação');
    } else {
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('Finances')
          .child('money')
          .set(moneyAvailable - moneyWithdraw);
    }
  }

  Future<String> getMoneyValue() async {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${_auth.currentUser!.uid}/Account/Finances');
    DatabaseEvent event = await _databaseReference.once();
    return event.snapshot.child('money').value.toString();
  }

  Map<dynamic, dynamic> getAllTransactions() {
    return {};
  }
}
