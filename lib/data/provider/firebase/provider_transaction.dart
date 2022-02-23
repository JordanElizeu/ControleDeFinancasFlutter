import 'dart:async';
import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../../../string_i18n.dart';

class ProviderTransactions {
  final RepositoryConnection repositoryConnection;

  ProviderTransactions({required this.repositoryConnection});

  Future<void> addTransaction(
      {required ModelTransaction modelAddTransaction}) async {
    final map = await getAllTransactions();
    final String id = '${map.length}a';
    final DatabaseReference databaseReference =
        repositoryConnection.connectionDatabase();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnMoney)
        .set(modelAddTransaction.quantityMoney);
    databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnTitle)
        .set(modelAddTransaction.title);
    databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnDescription)
        .set(modelAddTransaction.description);
    databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnUid)
        .set(id);
    databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnIsDeposit)
        .set(modelAddTransaction.isDeposit);
    databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnDate)
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

  Future<Map?> getAvailableMoney() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${repositoryConnection.connectionFirebaseAuth().currentUser!.uid}/$pathAccount/$pathFinances');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }

  Future<Map<dynamic, dynamic>> getAllTransactions() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${repositoryConnection.connectionFirebaseAuth().currentUser!.uid}/$pathAccount/$pathFinances/$pathTransaction');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
