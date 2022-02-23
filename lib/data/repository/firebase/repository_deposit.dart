import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_deposit.dart';
import '../../../injection/injection.dart';

class RepositoryDeposit {
  final ProviderDeposit _providerTransactions = getIt.get();

  Future<bool> repositoryAddDeposit(
      {required ModelTransaction modelTransaction}) {
    return _providerTransactions.addDeposit(modelTransaction: modelTransaction);
  }
}
