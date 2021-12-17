import 'package:app_financeiro/data/provider/firebase/provider_deposit.dart';
import 'package:flutter/cupertino.dart';

class RepositoryDeposit extends ProviderDeposit {

  Future<void> repositoryAddDeposit(
      {required double quantityMoney,
      required String title,
      required BuildContext context,
      required String description}) {
    return addDeposit(
        quantityMoney: quantityMoney,
        description: description,
        context: context,
        title: title);
  }
}
