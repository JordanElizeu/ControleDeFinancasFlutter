import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';

class ProviderWithdraw {
  final ProviderTransactions _providerTransactions;

  ProviderWithdraw(this._providerTransactions);

  Future<bool> providerMoneyWithdraw(
      {required ModelTransaction modelTransaction}) async {
    Map mapValueMoney = await _providerTransactions.getAvailableMoney();
    double availableMoney = double.parse(mapValueMoney['money'].toString());
    if (modelTransaction.quantityMoney > availableMoney) {
      alertDialogViewFailure(
          titleError: 'Saldo insuficiente',
          context: modelTransaction.context,
          messageError: 'Saldo em conta insufiente');
      return false;
    } else {
      try {
        _providerTransactions.databaseReference
            .child('AppFinancas')
            .child(_providerTransactions.firebaseAuth.currentUser!.uid)
            .child('Account')
            .child('Finances')
            .child('money')
            .set(availableMoney - modelTransaction.quantityMoney);
        await _providerTransactions.addTransaction(
            modelAddTransaction: modelTransaction);
        return true;
      } catch (exception) {
        alertDialogViewFailure(
            titleError: 'Erro inesperado',
            context: modelTransaction.context,
            messageError: 'Ocorreu um erro inesperado');
        return false;
      }
    }
  }
}
