import 'package:app_financeiro/data/provider/firebase/provider_createuser.dart';
import 'package:app_financeiro/injection/injection.dart';
import '../../model/login_model/create_user_model.dart';

class RepositoryCreateUser{

  ProviderCreateUser _providerCreateUser = getIt.get<ProviderCreateUser>();

  Future<String?> repositorySignUpFirebase(
      {required CreateUserModel modelCreateUser}) async {
    return await _providerCreateUser
        .providerCreateFirebaseUser(modelCreateUser: modelCreateUser);
  }
}