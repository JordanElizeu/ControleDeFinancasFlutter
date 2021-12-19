import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';

class RepositoryTransactions {
  final ProviderTransactions _providerTransactions = ProviderTransactions(
      databaseReference: RepositoryConnection.connectionDatabase(),
      firebaseAuth: RepositoryConnection.connectionFirebaseAuth());

  Future<Map> repositoryGetQuantityMoney() async {
    return await _providerTransactions.getAvailableMoney();
  }

  Future<Map<dynamic, dynamic>> repositoryGetAllTransactions() async {
    return _providerTransactions.getAllTransactions();
  }
}
