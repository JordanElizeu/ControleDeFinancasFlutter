import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryTransactions {
  final ProviderTransactions _providerTransactions = getIt.get<ProviderTransactions>();

  Future<Map?> repositoryGetQuantityMoney() async {
    return await _providerTransactions.getAvailableMoney();
  }

  Future<Map<dynamic, dynamic>> repositoryGetAllTransactions() async {
    return _providerTransactions.getAllTransactions();
  }
}
