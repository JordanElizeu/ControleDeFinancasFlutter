import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryFirebaseLogin {
  ProviderLoginFirebase providerLoginFirebase =
      getIt.get<ProviderLoginFirebase>();

  Future<String?> repositorySignInFirebase(
      {required ModelLogin modelLogin}) async {
    return await providerLoginFirebase.providerSignInWithFirebase(
        modelLogin: modelLogin);
  }
}
