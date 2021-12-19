import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_createdeposit.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';

class RepositoryDeposit {
  final ProviderDeposit _providerTransactions = ProviderDeposit(
      new ProviderTransactions(
          firebaseAuth: RepositoryConnection.connectionFirebaseAuth(),
          databaseReference: RepositoryConnection.connectionDatabase()));

  Future<bool> repositoryAddDeposit(
      {required ModelTransaction modelTransaction}) {
    return _providerTransactions.addDeposit(modelTransaction: modelTransaction);
  }
}
