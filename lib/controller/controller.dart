import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{

  final BuildContext _context;

  Controller(this._context);

  void pageTransition({required String route}){
    Navigator.of(_context).pushNamed(route);
  }

  Future<bool> finishAndPageTransition({required String route}) async{
    try{
      await Navigator.of(_context).popAndPushNamed(route);
      return true;
    }catch(e){
      return false;
    }
  }
}