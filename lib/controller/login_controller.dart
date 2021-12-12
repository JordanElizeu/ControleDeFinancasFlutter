import 'package:app_financeiro/data/repository/repository_googleconnection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  void signInGoogle({required BuildContext context}){
    RepositoryGoogleConnection().signInGoogle(context);
  }
}