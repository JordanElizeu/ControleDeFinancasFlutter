import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{

  final BuildContext _context;

  Controller(this._context);

  void pageTransition({required String route}){
    Navigator.of(_context).pushNamed(route);
  }

  void finishAndPageTransition({required String route}){
    Navigator.of(_context).popAndPushNamed(route);
  }
}