import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/string_i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  Map<dynamic, dynamic> map = {};
  static List<String> listRent = [];
  static Map mapRent = {};
  final RepositoryTransactions _repositoryTransactions =
      getIt.get<RepositoryTransactions>();

  Future<Map> getAllTransactions(BuildContext context) async {
    map = await _repositoryTransactions.repositoryGetAllTransactions();
    return map;
  }

  Future<List<String>> getTodoRent() async {
    List<String> list = [];
    mapRent = await _repositoryTransactions.repositoryGetTodoRent();
    for (int index = 1; index <= mapRent.length; index++) {
      list.add(mapRent['${index}a'][columnTitle]);
    }
    if (list.length > 1) {
      list.forEach((element) {
        if (element[0] == generalAccount) {
          list.removeAt(0);
        }
      });
    }
    if (list.length != listRent.length) {
      listRent.addAll(list);
    }
    if (list.isEmpty) {
      listRent.add(generalAccount);
    }
    return listRent;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
