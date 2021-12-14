import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController{

  final BuildContext _context;

  TransactionController(this._context);

  Future<Map<dynamic,dynamic>> getAllTransactions(){
    return RepositoryTransactions(_context).repositoryGetAllTransactions();
  }
}