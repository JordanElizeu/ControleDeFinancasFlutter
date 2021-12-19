import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryTransactions extends ProviderTransactions{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map> repositoryGetQuantityMoney() async {
    return await getAvailableMoney(auth: _auth);
  }

  Future<Map<dynamic,dynamic>> repositoryGetAllTransactions() async {
    return getAllTransactions(auth: _auth);
  }
}
