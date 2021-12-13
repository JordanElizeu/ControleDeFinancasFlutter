import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget error404() {
  return Center(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('assets/images/error404.png'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Erro 404',
                style: TextStyle(color: Colors.red, fontSize: 32.0),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
