import 'package:app_financeiro/data/provider/firebase/provider_transactions.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ProviderDeposit extends ProviderTransactions {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addDeposit(
      {required double quantityMoney,
      required String title,
      required BuildContext context,
      required String description}) async {
    try {
      Map value = await getAvailableMoney(auth: _auth);
      double availableMoney = double.parse(value['money'].toString());
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('Finances')
          .child('money')
          .set((quantityMoney + availableMoney).toString());
      await addTransaction(
          quantityMoney: quantityMoney,
          title: title,
          description: description,
          isDeposit: true,
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
