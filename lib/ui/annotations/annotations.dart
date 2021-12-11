import 'package:app_financeiro/ui/annotations/widgets/createannotations.dart';
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
              onPressed: (){
                alertDialogCreateAnnotation(function: () {}, context: context);
              },
              child: Icon(Icons.message),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ListTile(
                title: Text('Minha primeira anotação'),
                subtitle: Text('descrição da primeira anotação'),
              ),
              Text('Valor: R\$ 2500,00')
            ],
          )
        ],
      ),
    );
  }
}
