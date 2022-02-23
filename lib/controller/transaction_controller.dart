import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  Map<dynamic, dynamic> map = {};
  final RepositoryTransactions _repositoryTransactions =
      getIt.get<RepositoryTransactions>();

  Future<Map> getAllTransactions(BuildContext context) async {
    map = await _repositoryTransactions.repositoryGetAllTransactions();
    return map;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
