import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController{

  Future<Map<dynamic,dynamic>> getAllTransactions(BuildContext context){
    return RepositoryTransactions(context).getAllTransactions();
  }
}