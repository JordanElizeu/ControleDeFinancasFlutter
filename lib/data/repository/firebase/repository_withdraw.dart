import 'package:app_financeiro/data/provider/firebase/provider_withdraw.dart';
import 'package:app_financeiro/injection/injection.dart';
import '../../model/transaction_model/transaction_model.dart';

class RepositoryWithdraw {
  final ProviderWithdraw _providerWithdraw = getIt.get<ProviderWithdraw>();

  Future<bool> repositoryMoneyWithdraw(
      {required TransactionModel modelTransaction}) async {
    return _providerWithdraw.providerMoneyWithdraw(
        modelTransaction: modelTransaction);
  }
}
