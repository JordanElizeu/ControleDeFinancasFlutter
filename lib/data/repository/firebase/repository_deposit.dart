import 'package:app_financeiro/data/model/model_deposit/model_deposit.dart';
import 'package:app_financeiro/data/provider/firebase/provider_deposit.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';

class RepositoryDeposit {
  final ProviderDeposit _providerTransactions = ProviderDeposit(
      RepositoryConnection.connectionDatabase(),
      RepositoryConnection.connectionFirebaseAuth());

  Future<bool> repositoryAddDeposit({required ModelDeposit modelDeposit}) {
    return _providerTransactions.addDeposit(modelDeposit: modelDeposit);
  }
}
