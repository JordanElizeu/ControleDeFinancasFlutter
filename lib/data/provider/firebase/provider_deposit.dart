import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import '../../../string_i18n.dart';

class ProviderDeposit extends ProviderTransactions {
  ProviderDeposit({required RepositoryConnection repositoryConnection})
      : super(repositoryConnection: repositoryConnection);

  Future<bool> addDeposit({required ModelTransaction modelTransaction}) async {
    try {
      double availableMoney = 0;
      await getAvailableMoney().then(
        (value) => {
          if (value![columnMoney] != null)
            {
              availableMoney = double.parse(value[columnMoney].toString()),
            }
        },
      );
      repositoryConnection
          .connectionDatabase()
          .child(pathAppFinances)
          .child(repositoryConnection.connectionFirebaseAuth().currentUser!.uid)
          .child(pathAccount)
          .child(pathFinances)
          .child(columnMoney)
          .set((modelTransaction.quantityMoney + availableMoney).toString());
      await addTransaction(modelAddTransaction: modelTransaction);
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
