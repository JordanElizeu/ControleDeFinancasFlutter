import 'package:app_financeiro/data/model/model_login/model_createuser.dart';
import 'package:app_financeiro/data/provider/firebase/provider_createuser.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryCreateUser{

  ProviderCreateUser _providerCreateUser = getIt.get<ProviderCreateUser>();

  Future<String?> repositorySignUpFirebase(
      {required ModelCreateUser modelCreateUser}) async {
    return await _providerCreateUser
        .providerCreateFirebaseUser(modelCreateUser: modelCreateUser);
  }
}