import 'package:app_financeiro/data/model/login_model/model_login.dart';
import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryFirebaseLogin {
  ProviderLoginFirebase providerLoginFirebase =
      getIt.get<ProviderLoginFirebase>();

  Future<String?> repositorySignInFirebase(
      {required LoginModel loginModel}) async {
    return await providerLoginFirebase.providerSignInWithFirebase(
        loginModel: loginModel);
  }
}
