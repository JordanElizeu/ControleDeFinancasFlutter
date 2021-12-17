import 'package:app_financeiro/data/provider/firebase/provider_transactions.dart';
import 'package:flutter/cupertino.dart';

class RepositoryTransactions {

  Future<String> repositoryGetQuantityMoney() async {
    return await ProviderTransactions().getAvailableMoney();
  }

  Future<bool?> repositoryMoneyWithdraw({
      required double value, required String title, required String description, required BuildContext context}) async {
    return await ProviderTransactions().moneyWithdraw(
        moneyWithdraw: value, context: context, title: title, description: description);
  }

  Future<bool?> repositoryDepositMoney(
      {required double quantityMoney,
      required String title,
      required String desc,
      required BuildContext context}) async {
    return await ProviderTransactions().addDeposit(
        title: title,
        description: desc,
        quantityMoney: quantityMoney,
        context: context);
  }

  Future<Map> repositoryGetAllTransactions() async {
    return await ProviderTransactions().getAllTransactions();
  }
}
