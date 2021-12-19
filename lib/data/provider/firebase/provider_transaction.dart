import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProviderTransactions {
  Future<void> addTransaction(
      {required double quantityMoney,
      required String title,
      required String description,
      required bool isDeposit,
      required FirebaseAuth auth,
      required DatabaseReference databaseReference}) async {
    final map = await getAllTransactions(auth: auth);
    final String id = '${map.length}a';
    databaseReference
        .child('AppFinancas')
        .child(auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('money')
        .set(quantityMoney);
    databaseReference
        .child('AppFinancas')
        .child(auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('title')
        .set(title);
    databaseReference
        .child('AppFinancas')
        .child(auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('description')
        .set(description);
    databaseReference
        .child('AppFinancas')
        .child(auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('uid')
        .set(id);
    databaseReference
        .child('AppFinancas')
        .child(auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('is_deposit')
        .set(isDeposit);
  }

  Future<Map> getAvailableMoney({required FirebaseAuth auth}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${auth.currentUser!.uid}/Account/Finances');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }

  Future<Map<dynamic, dynamic>> getAllTransactions(
      {required FirebaseAuth auth}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        'AppFinancas/${auth.currentUser!.uid}/Account/Finances/transactions');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
