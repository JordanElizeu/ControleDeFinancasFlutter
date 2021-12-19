import 'package:app_financeiro/data/model/model_deposit/model_deposit.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProviderDeposit extends ProviderTransactions {

  final DatabaseReference _databaseReference;
  final FirebaseAuth _auth;

  ProviderDeposit(this._databaseReference, this._auth);

  Future<bool> addDeposit({required ModelDeposit modelDeposit}) async {
    try {
      double availableMoney = double.parse(await _getMoneyValue());
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('Finances')
          .child('money')
          .set((modelDeposit.quantityMoney + availableMoney).toString());
      await addTransaction(
          quantityMoney: modelDeposit.quantityMoney,
          title: modelDeposit.title,
          description: modelDeposit.description,
          isDeposit: true,
          databaseReference: _databaseReference,
          auth: _auth);
      return true;
    } catch (exception) {
      alertDialogViewFailure(
          titleError: 'Erro inesperado',
          context: modelDeposit.context,
          messageError: 'Ocorreu um erro inesperado');
      return false;
    }
  }

  Future<String> _getMoneyValue() async {
    String moneyValue = '';
    await getAvailableMoney(auth: _auth).then((value) => {
      moneyValue = value['money'].toString()
    });
    return moneyValue;
  }
}
