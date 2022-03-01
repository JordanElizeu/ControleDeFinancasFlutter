import 'dart:async';
import 'package:app_financeiro/controller/transaction_controller.dart';
import 'package:app_financeiro/data/model/transaction_model/transaction_model.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../../../controller/home_controller.dart';
import '../../../string_i18n.dart';

class ProviderTransactions {
  final RepositoryConnection repositoryConnection;

  ProviderTransactions({required this.repositoryConnection});

  Future<void> addTransaction(
      {required TransactionModel modelAddTransaction}) async {
    final map = await getAllTransactions();
    final String id = '${map.length}a';
    final DatabaseReference databaseReference =
        repositoryConnection.connectionDatabase();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnMoney)
        .set(modelAddTransaction.quantityMoney);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnTitle)
        .set(modelAddTransaction.title);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnDescription)
        .set(modelAddTransaction.description);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnUid)
        .set(id);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnIsDeposit)
        .set(modelAddTransaction.isDeposit);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnDate)
        .set(getTodayDate());
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(pathTransaction)
        .child(id)
        .child(columnRent)
        .set(modelAddTransaction.textSelectRent);
  }

  Future<void> updateValueMoneyRent({
    required double valueMoney,
    required int index,
    required bool isDeposit,
  }) async {
    String id = '${index}a';
    final valueAvailableMoney =
        double.parse(TransactionController.mapRent[id][columnValueRent]);
    await repositoryConnection
        .connectionDatabase()
        .child(pathAppFinances)
        .child(repositoryConnection.connectionFirebaseAuth().currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(id)
        .child(columnValueRent)
        .set(isDeposit
            ? (valueMoney + valueAvailableMoney).toString()
            : (valueAvailableMoney - valueMoney).toString());
  }

  Future<void> updateValueMoney({
    required double valueMoney,
    required bool isDeposit,
  }) async {
    double? availableMoney;
    await getAvailableMoney().then(
      (value) => {
        if (value![columnMoney] != null)
          {
            availableMoney = double.parse(value[columnMoney].toString()),
          }
      },
    );
    if (isDeposit) {
      HomeController.moneyValue = (valueMoney + availableMoney!).toString();
    } else {
      HomeController.moneyValue = (valueMoney - availableMoney!).toString();
    }
    await repositoryConnection
        .connectionDatabase()
        .child(pathAppFinances)
        .child(repositoryConnection.connectionFirebaseAuth().currentUser!.uid)
        .child(pathAccount)
        .child(pathFinances)
        .child(columnMoney)
        .set(isDeposit
            ? valueMoney + availableMoney!
            : availableMoney! - valueMoney);
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

  Future<Map<dynamic, dynamic>> getTodoRent() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${repositoryConnection.connectionFirebaseAuth().currentUser!.uid}/$pathAccount/$pathRents');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
