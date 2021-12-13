import 'package:app_financeiro/data/provider/firebase/provider_transactions.dart';
import 'package:flutter/cupertino.dart';

class RepositoryTransactions{

  Future<String> getQuantityMoney() async{
    return await ProviderTransactions().getMoneyValue();
  }

  void moneyWithdraw(double value, BuildContext context){
    ProviderTransactions().moneyWithdraw(moneyWithdraw: value, context: context);
  }
}