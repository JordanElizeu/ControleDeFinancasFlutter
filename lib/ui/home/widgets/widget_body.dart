import 'package:app_financeiro/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bodyHome(){
  return PageView(
    controller: HomeController.pageController,
    children: [
      Container(color: Colors.red,),
      Container(color: Colors.blue,),
      Container(color: Colors.black,),
    ],
  );
}