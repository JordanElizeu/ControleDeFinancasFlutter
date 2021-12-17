import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController{

  static Map<dynamic,dynamic> map = {};

  Future<Map> getAllTransactions(BuildContext context) async {
    map = await RepositoryTransactions().repositoryGetAllTransactions();
    return map;
  }

  @override
  void dispose() {
    super.dispose();
  }
}