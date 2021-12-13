import 'package:app_financeiro/data/provider/firebase/provider_googleconnection.dart';
import 'package:flutter/cupertino.dart';

class RepositoryGoogleConnection{

  Future<String?> signInGoogle(BuildContext context) async{
    return await ProviderGoogleConnection().signInWithGoogle(context: context);
  }
}