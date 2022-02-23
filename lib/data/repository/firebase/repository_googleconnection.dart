import 'package:app_financeiro/data/provider/firebase/provider_createuser.dart';
import 'package:app_financeiro/data/provider/firebase/provider_googlelogin.dart';
import 'package:app_financeiro/data/provider/firebase/provider_user_information.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:flutter/cupertino.dart';

class RepositoryGoogleConnection {
  ProviderCreateUser _providerCreateUser = getIt.get<ProviderCreateUser>();
  ProviderInformationOfUser _providerInformationOfUser =
      getIt.get<ProviderInformationOfUser>();

  Future<String?> repositorySignInGoogle(BuildContext context) async {
    return await ProviderGoogleLogin().signInWithGoogle(
        context: context,
        providerCreateUser: _providerCreateUser,
        providerInformationOfUser: _providerInformationOfUser);
  }
}
