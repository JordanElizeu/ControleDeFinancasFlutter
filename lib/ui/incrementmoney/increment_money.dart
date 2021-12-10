import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncrementMoney extends StatelessWidget {
  const IncrementMoney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: Text('Valor')
          ),
        )
      ],
    );
  }
}
