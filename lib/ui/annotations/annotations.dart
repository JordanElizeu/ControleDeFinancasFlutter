import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Annotations extends StatelessWidget {
  const Annotations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anotações'),
        actions: [
          Container(
            child: ElevatedButton(
              onPressed: () {

              },
              child: Icon(Icons.message),
            ),
          )
        ],
      ),
    );
  }
}
