import 'package:app_financeiro/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget navigationBar() {
  return
    AnimatedBuilder(
        animation: HomeController.pageController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: (index) {
              HomeController.pageController.jumpToPage(index);
            },
            currentIndex: HomeController.pageController.page?.round() ?? 1,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Histórico'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            ],
          );
        });
}