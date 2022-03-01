import 'package:app_financeiro/data/model/financial_rent_model/edit_rent_model.dart';
import 'package:app_financeiro/data/model/financial_rent_model/financial_rent_model.dart';
import 'package:app_financeiro/data/provider/firebase/provider_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../string_i18n.dart';

class ProviderFinancialRent extends ProviderTransactions {
  ProviderFinancialRent({required RepositoryConnection repositoryConnection})
      : super(repositoryConnection: repositoryConnection);

  Future<void> createNewRent({required FinancialRentModel rentModel}) async {
    final String id = await _getLengthAnnotation();
    final DatabaseReference databaseReference =
        repositoryConnection.connectionDatabase();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(id)
        .child(columnDescription)
        .set(rentModel.description);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(id)
        .child(columnTitle)
        .set(rentModel.title);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(id)
        .child(columnUid)
        .set(id);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(id)
        .child(columnValueRent)
        .set(rentModel.valueMoney);
    await updateValueMoney(
      valueMoney: double.parse(rentModel.valueMoney),
      isDeposit: true,
    );
  }

  Future<void> providerRemoveRent({required String uid}) async {
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${auth.currentUser!.uid}/$pathAccount/$pathRents/$uid');
    DatabaseEvent event = await databaseReference.once();
    double moneyValue =
        double.parse(event.snapshot.child(columnValueRent).value as String);
    await updateValueMoney(
      valueMoney: moneyValue,
      isDeposit: false,
    );
    await databaseReference.remove();
  }

  Future<void> updateRent({required EditRentModel editRentModel}) async {
    final DatabaseReference databaseReference =
        repositoryConnection.connectionDatabase();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(editRentModel.id)
        .child(columnDescription)
        .set(editRentModel.description);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(editRentModel.id)
        .child(columnTitle)
        .set(editRentModel.title);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathRents)
        .child(editRentModel.id)
        .child(columnUid)
        .set(editRentModel.id);
  }

  Future<String> _getLengthAnnotation() async {
    String rentLength = '';
    int length;
    await providerGetTodoRends().then(
      (value) => {
        length = value.length + 1,
        rentLength = "${length.toString()}a",
      },
    );
    return rentLength;
  }

  Future<Map<dynamic, dynamic>> providerGetTodoRends() async {
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${auth.currentUser!.uid}/$pathAccount/$pathRents');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
