import 'package:app_financeiro/data/provider/provider_googleconnection.dart';
import 'package:flutter/cupertino.dart';

class RepositoryGoogleConnection{

  void signInGoogle(BuildContext context){
    ProviderGoogleConnection().signInWithGoogle(context: context);
  }
}