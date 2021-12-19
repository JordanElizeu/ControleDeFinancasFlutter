import 'package:app_financeiro/data/provider/firebase/provider_googlelogin.dart';
import 'package:flutter/cupertino.dart';

class RepositoryGoogleConnection{

  Future<String?> repositorySignInGoogle(BuildContext context) async{
    return await ProviderGoogleLogin().signInWithGoogle(context: context);
  }
}