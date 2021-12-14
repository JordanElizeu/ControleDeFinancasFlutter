import 'package:app_financeiro/data/provider/firebase/provider_transactions.dart';
import 'package:flutter/cupertino.dart';

class RepositoryTransactions {
  final BuildContext _context;

  RepositoryTransactions(this._context);

  Future<String> getQuantityMoney() async {
    return await ProviderTransactions().getAvailableMoney();
  }

  Future<bool?> moneyWithdraw(
      double value, String title, String description) async {
    return await ProviderTransactions().moneyWithdraw(
        moneyWithdraw: value, context: _context, title: title, description: description);
  }

  Future<bool?> depositMoney(
      {required double quantityMoney,
      required String title,
      required String desc}) async {
    return await ProviderTransactions().addDeposit(
        title: title,
        description: desc,
        quantityMoney: quantityMoney,
        context: _context);
  }

  Future<Map<dynamic, dynamic>> getAllTransactions() async {
    return await ProviderTransactions().getAllTransactions();
  }
}
