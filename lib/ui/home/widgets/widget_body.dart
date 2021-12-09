import 'package:app_financeiro/controller/home_controller.dart';
import 'package:app_financeiro/ui/initial/page_initial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bodyHome(){
  return PageView(
    controller: HomeController.pageController,
    children: [
      Container(color: Colors.blue,),
      PageInitial(),
      Container(color: Colors.black,),
    ],
  );
}