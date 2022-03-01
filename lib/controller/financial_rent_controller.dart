import 'package:app_financeiro/data/model/financial_rent_model/financial_rent_model.dart';
import 'package:app_financeiro/data/repository/firebase/repository_financial_rent.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/model/financial_rent_model/edit_rent_model.dart';
import '../injection/injection.dart';
import '../utils/form_validation.dart';

class FinancialRentController extends GetxController {
  Map<dynamic, dynamic> rentMap = {};

  final TextEditingController textEditingControllerRentTitle =
      TextEditingController();
  final TextEditingController textEditingControllerRentDescription =
      TextEditingController();
  final TextEditingController textEditingControllerRentValueMoney =
      TextEditingController();
  final RepositoryFinancialRent _repositoryFinancialRent =
      getIt.get<RepositoryFinancialRent>();
  bool addRentWithValueInitial = false;

  Future<bool> createNewRent(
      {required BuildContext context,
      required String title,
      required GlobalKey<FormState> formKeyDescription,
      required GlobalKey<FormState> formKeyTitle,
      required GlobalKey<FormState> formKeyValueMoney,
      required String description}) async {
    final FormState? formValidateTitle = formKeyTitle.currentState;
    final FormState? formValidateAnnotation = formKeyDescription.currentState;
    final FormState? formValidateValueMoney = formKeyValueMoney.currentState;
    if (formValidateTitle!.validate() &&
        formValidateAnnotation!.validate() &&
        formValidateValueMoney!.validate()) {
      await _repositoryFinancialRent.repositoryCreateNewRent(
          rentModel: FinancialRentModel(
        description: description,
        context: context,
        title: title,
        valueMoney: textEditingControllerRentValueMoney.text.isEmpty
            ? '0'
            : formatValueMoney(
                textValue: textEditingControllerRentValueMoney.text),
      ));
      await Future.delayed(Duration(milliseconds: 300)).then((value) async => {
            await getTodo(),
            clearFields(context: context),
            update(),
          });
      return true;
    }
    return false;
  }

  void changeAddRentWithValueInitial({required bool value}) {
    addRentWithValueInitial = value;
    update();
  }

  void clearFields({required BuildContext context}) async {
    textEditingControllerRentTitle.text = '';
    textEditingControllerRentDescription.text = '';
    update();
  }

  Future<Map<dynamic, dynamic>> getTodo() async {
    rentMap = await _repositoryFinancialRent.repositoryGetTodo();
    return rentMap;
  }

  Future<void> removeRent(
      {required String id, required BuildContext context}) async {
    await _repositoryFinancialRent.removeRent(id: id);
    update();
  }

  Future<void> editRent(
      {required String id,
      required BuildContext context,
      required int index}) async {
    rentMap[index] = {
      0: textEditingControllerRentTitle.text,
      1: textEditingControllerRentDescription.text
    };
    await _repositoryFinancialRent.editRent(
        editRentModel: EditRentModel(
      id: id,
      title: textEditingControllerRentTitle.text,
      context: context,
      description: textEditingControllerRentDescription.text,
      valueMoney: textEditingControllerRentValueMoney.text,
    ));
    clearFields(context: context);
    update();
  }

  void recoverRent({required Map<dynamic, dynamic> map}) async {
    this.rentMap.addAll(map);
    update();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingControllerRentTitle.dispose();
    textEditingControllerRentDescription.dispose();
  }
}
