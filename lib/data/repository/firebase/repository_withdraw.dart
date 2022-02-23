import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/provider/firebase/provider_withdraw.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryWithdraw {
  final ProviderWithdraw _providerWithdraw = getIt.get<ProviderWithdraw>();

  Future<bool> repositoryMoneyWithdraw(
      {required ModelTransaction modelTransaction}) async {
    return _providerWithdraw.providerMoneyWithdraw(
        modelTransaction: modelTransaction);
  }
}
