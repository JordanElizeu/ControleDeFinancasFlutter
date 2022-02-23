import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:app_financeiro/data/model/model_annotation/model_editannotation.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../string_i18n.dart';

class ProviderAnnotations {
  final RepositoryConnection repositoryConnection;

  ProviderAnnotations({required this.repositoryConnection});

  Future<void> providerSendAnnotation(
      {required ModelAnnotation modelAnnotation}) async {
    final String id = await _getLengthAnnotation();
    final DatabaseReference databaseReference =
        repositoryConnection.connectionDatabase();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathAnnotation)
        .child(id)
        .child(columnAnnotation)
        .set(modelAnnotation.annotation);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathAnnotation)
        .child(id)
        .child(columnTitle)
        .set(modelAnnotation.titleAnnotation);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathAnnotation)
        .child(id)
        .child(columnUid)
        .set(id);
  }

  Future<String> _getLengthAnnotation() async {
    String lengthAnnotation = '';
    await providerGetAllAnnotations()
        .then((value) => {lengthAnnotation = "${value.length.toString()}a"});
    return lengthAnnotation;
  }

  Future<void> providerEditAnnotation(
      {required ModelEditAnnotation modelEditAnnotation}) async {
    final DatabaseReference databaseReference =
        repositoryConnection.connectionDatabase();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathAnnotation)
        .child(modelEditAnnotation.id)
        .child(columnAnnotation)
        .set(modelEditAnnotation.annotation);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathAnnotation)
        .child(modelEditAnnotation.id)
        .child(columnTitle)
        .set(modelEditAnnotation.titleAnnotation);
    await databaseReference
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(pathAnnotation)
        .child(modelEditAnnotation.id)
        .child(columnUid)
        .set(modelEditAnnotation.id);
  }

  Future<void> providerRemoveAnnotation({required String uid}) async {
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${auth.currentUser!.uid}/$pathAccount/$pathAnnotation/$uid');
    await databaseReference.remove();
  }

  Future<Map<dynamic, dynamic>> providerGetAllAnnotations() async {
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref(
        '$pathAppFinances/${auth.currentUser!.uid}/$pathAccount/$pathAnnotation');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
