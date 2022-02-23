import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import '../../../string_i18n.dart';

class ProviderWithdraw extends ProviderTransactions {
  ProviderWithdraw({required RepositoryConnection repositoryConnection})
      : super(repositoryConnection: repositoryConnection);

  Future<bool> providerMoneyWithdraw(
      {required ModelTransaction modelTransaction}) async {
    double availableMoney = 0;
    await getAvailableMoney().then((value) => {
          if (value![columnMoney] != null)
            {
              availableMoney = double.parse(value[columnMoney].toString()),
            }
        });
    if (modelTransaction.quantityMoney > availableMoney) {
      alertDialogViewFailure(
          titleError: 'Saldo insuficiente',
          context: modelTransaction.context,
          messageError: 'Saldo em conta insufiente');
      return false;
    } else {
      try {
        repositoryConnection.connectionDatabase()
            .child(pathAppFinances)
            .child(repositoryConnection.connectionFirebaseAuth().currentUser!.uid)
            .child(pathAccount)
            .child(pathFinances)
            .child(columnMoney)
            .set(availableMoney - modelTransaction.quantityMoney);
        await addTransaction(
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
