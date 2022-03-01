import 'package:app_financeiro/data/model/financial_rent_model/edit_rent_model.dart';
import 'package:app_financeiro/data/model/financial_rent_model/financial_rent_model.dart';
import 'package:app_financeiro/data/provider/firebase/provider_financial_rent.dart';
import '../../../injection/injection.dart';

class RepositoryFinancialRent {
  final ProviderFinancialRent _providerRent =
      getIt.get<ProviderFinancialRent>();

  Future<void> repositoryCreateNewRent(
      {required FinancialRentModel rentModel}) async {
    await _providerRent.createNewRent(rentModel: rentModel);
  }

  Future<Map<dynamic, dynamic>> repositoryGetTodo() {
    return _providerRent.providerGetTodoRends();
  }

  Future<void> editRent({required EditRentModel editRentModel}) async {
    await _providerRent.updateRent(editRentModel: editRentModel);
  }

  Future<void> removeRent({required String id}) async {
    await _providerRent.providerRemoveRent(uid: id);
  }
}
