import 'package:app_financeiro/data/provider/firebase/provider_withdraw.dart';
import 'package:flutter/cupertino.dart';

class RepositoryWithdraw extends ProviderWithdraw {

  Future<void> repositoryMoneyWithdraw(
      {required double moneyWithdraw,
      required BuildContext context,
      required String description,
      required String title}) async {
    providerMoneyWithdraw(
        title: title,
        description: description,
        context: context,
        moneyWithdraw: moneyWithdraw);
  }
}
