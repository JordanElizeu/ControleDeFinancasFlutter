import 'package:app_financeiro/data/model/transaction_model/transaction_model.dart';
import 'package:app_financeiro/data/provider/firebase/provider_deposit.dart';
import '../../../injection/injection.dart';

class RepositoryDeposit {
  final ProviderDeposit _providerTransactions = getIt.get();

  Future<bool> repositoryAddDeposit(
      {required TransactionModel modelTransaction}) {
    return _providerTransactions.addDeposit(modelTransaction: modelTransaction);
  }
}
