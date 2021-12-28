import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';

class ProviderDeposit {
  final ProviderTransactions _providerTransactions;

  ProviderDeposit(this._providerTransactions);

  Future<bool> addDeposit({required ModelTransaction modelTransaction}) async {
    try {
      double availableMoney = 0;
      await _providerTransactions.getAvailableMoney().then((value) =>
          {availableMoney = double.parse(value['money'].toString())});
      _providerTransactions.databaseReference
          .child('AppFinancas')
          .child(_providerTransactions.firebaseAuth.currentUser!.uid)
          .child('Account')
          .child('Finances')
          .child('money')
          .set((modelTransaction.quantityMoney + availableMoney).toString());
      await _providerTransactions.addTransaction(
          modelAddTransaction: modelTransaction);
      return true;
    } catch (exception) {
      alertDialogViewFailure(
          titleError: 'Erro inesperado',
          context: modelTransaction.context,
          messageError: 'Ocorreu um erro inesperado $exception}');
      return false;
    }
  }
}
