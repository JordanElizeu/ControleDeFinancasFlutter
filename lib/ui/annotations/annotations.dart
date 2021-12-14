import 'dart:ui';

import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/ui/annotations/widgets/createannotations.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Annotations extends StatelessWidget {
  const Annotations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnnotationsController annotationsController = AnnotationsController(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Anotações'),
        actions: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                alertDialogCreateAnnotation(
                    function: () {
                      annotationsController.sendAnnotation();
                    },
                    context: context);
              },
              child: Icon(Icons.message),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: annotationsController.getAllAnnotations(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return error404();
              case ConnectionState.waiting:
                return progress();
              case ConnectionState.active:
                return progress();
              case ConnectionState.done:
                return _widgetFutureBuilder(snapshot);
            }
          } else if (snapshot.hasError) {
            return error404(title: '0 anotações');
          }
          return progress();
        },
      ),
    );
  }

  Widget _widgetFutureBuilder(AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.purple,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${snapshot.data!.values.toList().asMap()[index]['title']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                              child: Image.asset('assets/images/foguete.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '${snapshot.data!.values.toList().asMap()[index]['annotation']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange)),
                          onPressed: () {},
                          child: Icon(Icons.edit),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange)),
                          onPressed: () {},
                          child: Icon(Icons.delete_forever),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
