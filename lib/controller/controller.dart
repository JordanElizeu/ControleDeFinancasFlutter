import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{

  void pageTransition({required String route, required BuildContext context}){
    Navigator.of(context).pushNamed(route);
  }

  void finishAndPageTransition({required String route, required BuildContext context}){
    Navigator.of(context).popAndPushNamed(route);
  }
}