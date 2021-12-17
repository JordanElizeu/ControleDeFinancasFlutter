import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{

  void pageTransition({required String route,required BuildContext context}){
    Navigator.of(context).pushNamed(route);
  }

  Future<bool> finishAndPageTransition({required String route,required BuildContext context}) async{
    try{
      await Navigator.of(context).popAndPushNamed(route);
      return true;
    }catch(e){
      return false;
    }
  }
}