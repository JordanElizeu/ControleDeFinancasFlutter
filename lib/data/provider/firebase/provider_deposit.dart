import 'package:app_financeiro/data/model/transaction_model/transaction_model.dart';
import 'package:app_financeiro/injection/injection_depedencies.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import '../../../string_i18n.dart';

class ProviderDeposit extends ProviderTransactions {
  ProviderDeposit({required RepositoryConnection repositoryConnection})
      : super(repositoryConnection: repositoryConnection);

  Future<bool> addDeposit({required TransactionModel modelTransaction}) async {
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
      await repositoryConnection
          .connectionDatabase()
          .child(pathAppFinances)
          .child(repositoryConnection.connectionFirebaseAuth().currentUser!.uid)
          .child(pathAccount)
          .child(pathFinances)
          .child(columnMoney)
          .set((modelTransaction.quantityMoney + availableMoney).toString());
      int? index;
      if (DepositMoneyController.valueSelectedButton != generalAccount) {
        for (int x = 0; x < TransactionController.listRent.length; x++) {
          if (TransactionController.listRent[x] ==
              DepositMoneyController.valueSelectedButton) {
            index = x;
          }
        }
        await updateValueMoneyRent(
          valueMoney: modelTransaction.quantityMoney,
          index: index!,
          isDeposit: true,
        );
      }
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
