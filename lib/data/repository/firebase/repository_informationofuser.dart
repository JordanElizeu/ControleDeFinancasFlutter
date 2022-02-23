import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:app_financeiro/data/provider/firebase/provider_user_information.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryInformationOfUser {
  ProviderInformationOfUser _providerInformationOfUser =
      getIt.get<ProviderInformationOfUser>();
  ProviderLoginFirebase _providerLoginFirebase =
      getIt.get<ProviderLoginFirebase>();

  Future<String?> repositoryGetNameIfUserIsFromFirebase() async {
    return await _providerInformationOfUser
        .providerGetNameIfUserIsFromFirebase();
  }

  Future<String?> repositoryForgotPasswordFirebase(
      {required String email}) async {
    return await _providerLoginFirebase.providerForgotPassword(email);
  }
}
