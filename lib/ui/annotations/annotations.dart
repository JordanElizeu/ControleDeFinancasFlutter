import 'dart:ui';

import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/annotations/widgets/widget_createannotations.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Annotations extends StatelessWidget {
  const Annotations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnnotationsController dx = Get.put(AnnotationsController());
    return WillPopScope(
      onWillPop: () =>
          Controller(context).finishAndPageTransition(route: Routes.HOME),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anotações'),
          actions: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  alertDialogCreateAnnotation(context: context);
                },
                child: Icon(Icons.message),
              ),
            )
          ],
        ),
        body: GetBuilder<AnnotationsController>(
          builder: (_) => FutureBuilder(
            future: _.getAllAnnotations(context: context),
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
                    return _widgetFutureBuilder(snapshot,dx);
                }
              } else if (snapshot.hasError) {
                return error404(title: '0 anotações');
              }
              return progress();
            },
          ),
        ),
      ),
    );
  }

  Widget _widgetFutureBuilder(AsyncSnapshot<Map<dynamic, dynamic>> snapshot,AnnotationsController dx) {
    return ListView.builder(
      itemCount: dx.map.length,
      itemBuilder: (BuildContext context, index) {
        return Dismissible(
          onDismissed: (DismissDirection dismissDirection) {
            dx.removeAnnotation(
                uid: snapshot.data!.values.toList().asMap()[index]['uid'],
                context: context);
            dx.map.remove(index);
            final snackBar = SnackBar(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.purple,
              content: Text(
                "Anotação removida!",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              action: SnackBarAction(
                textColor: Colors.white,
                label: "Desfazer",
                onPressed: () async {
                  dx.recoverAnnotation(
                      map: snapshot.data!.values.toList().asMap()[index],
                      context: context);
                },
              ),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          background: Card(
            color: Colors.red,
            child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${snapshot.data!.values.toList().asMap()[index]['title']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
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
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${snapshot.data!.values.toList().asMap()[index]['annotation']}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange)),
                          onPressed: () {
                            alertDialogCreateAnnotation(
                                context: context,
                                initialValueAnnotation: snapshot.data!.values
                                    .toList()
                                    .asMap()[index]['annotation'],
                                initialValueTitle: snapshot.data!.values
                                    .toList()
                                    .asMap()[index]['title'],
                                function: () {
                                  dx.editAnnotation(
                                      uid: snapshot.data!.values
                                          .toList()
                                          .asMap()[index]['uid'],
                                      context: context, index: index);
                                  Navigator.pop(CreateAnnotations.context!);
                                });
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
