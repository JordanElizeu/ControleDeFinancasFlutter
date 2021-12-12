import 'package:firebase_database/firebase_database.dart';

class ProviderTransactions{

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void addDeposit({required double quantityMoney}){
    _databaseReference.child('AppFinancas')
        .child('Account')
        .child('Finances')
        .child('money')
        .set(quantityMoney);
  }

  void makingWithdraw(){

  }

  String getMoneyValue(){
      return '';
  }

  Map<dynamic,dynamic> getAllTransactions(){
    return {};
  }
}