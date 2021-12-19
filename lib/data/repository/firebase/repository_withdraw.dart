import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_withdraw.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';

class RepositoryWithdraw {
  final ProviderWithdraw _providerWithdraw = ProviderWithdraw(
      new ProviderTransactions(
          databaseReference: RepositoryConnection.connectionDatabase(),
          firebaseAuth: RepositoryConnection.connectionFirebaseAuth()));

  Future<bool> repositoryMoneyWithdraw(
      {required ModelTransaction modelTransaction}) async {
    return _providerWithdraw.providerMoneyWithdraw(modelTransaction: modelTransaction);
  }
}
