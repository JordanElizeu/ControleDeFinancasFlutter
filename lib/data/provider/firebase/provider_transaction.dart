import 'dart:async';
import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ProviderTransactions {
  final DatabaseReference databaseReference;
  final FirebaseAuth firebaseAuth;

  ProviderTransactions(
      {required this.databaseReference, required this.firebaseAuth});

  Future<void> addTransaction(
      {required ModelTransaction modelAddTransaction}) async {
    final map = await getAllTransactions();
    final String id = '${map.length}a';
    databaseReference
        .child('AppFinancas')
        .child(firebaseAuth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('money')
        .set(modelAddTransaction.quantityMoney);
    databaseReference
        .child('AppFinancas')
        .child(firebaseAuth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('title')
        .set(modelAddTransaction.title);
    databaseReference
        .child('AppFinancas')
        .child(firebaseAuth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('description')
        .set(modelAddTransaction.description);
    databaseReference
        .child('AppFinancas')
        .child(firebaseAuth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('uid')
        .set(id);
    databaseReference
        .child('AppFinancas')
        .child(firebaseAuth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('is_deposit')
        .set(modelAddTransaction.isDeposit);
    databaseReference
        .child('AppFinancas')
        .child(firebaseAuth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('transactions')
        .child(id)
        .child('data')
        .set(getTodayDate());
  }

  String getTodayDate() {
    DateFormat dateFormat = DateFormat();
    var format = dateFormat.add_Hms();
    final String dateString = '${DateTime.now().day}/'
        '${DateTime.now().month}/'
        '${DateTime.now().year} '
        '${format.format(DateTime.now())}';
    return dateString;
  }

  Future<Map> getAvailableMoney() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${firebaseAuth.currentUser!.uid}/Account/Finances');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }

  Future<Map<dynamic, dynamic>> getAllTransactions() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        'AppFinancas/${firebaseAuth.currentUser!.uid}/Account/Finances/transactions');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
