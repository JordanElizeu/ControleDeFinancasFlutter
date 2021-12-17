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
    AnnotationsController annotationController =
        Get.put(AnnotationsController());
    return WillPopScope(
      onWillPop: () => Controller()
          .finishAndPageTransition(route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anotações'),
          actions: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  alertDialogCreateAnnotation(
                      context: context,
                      function: () async {
                        await annotationController.sendAnnotation(
                            context: context);
                        Navigator.pop(CreateAnnotations.context!);
                      });
                },
                child: Icon(Icons.message),
              ),
            )
          ],
        ),
        body: GetBuilder<AnnotationsController>(
          builder: (_) => FutureBuilder(
            future: _.getAllAnnotations(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<dynamic,dynamic>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.length > 0) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return error404();
                  case ConnectionState.waiting:
                    return progress();
                  case ConnectionState.active:
                    return progress();
                  case ConnectionState.done:
                    return _widgetFutureBuilder(snapshot, _);
                }
              } else if (snapshot.hasError) {
                return error404(title: '0 anotações');
              } else if (snapshot.data != null && snapshot.data!.length < 1) {
                return error404(title: '0 anotações');
              }
              return progress();
            },
          ),
        ),
      ),
    );
  }

  Widget _widgetFutureBuilder(AsyncSnapshot<Map<dynamic,dynamic>> snapshot,
      AnnotationsController annotationController) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        //this class has how function of remove effect scroll listview
        return false;
      },
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: AnnotationsController.map.length,
        itemBuilder: (BuildContext context, index) {
          bool cancelRemove = false;
          return Dismissible(
            onDismissed: (DismissDirection dismissDirection) {
              Future.delayed(Duration(seconds: 4)).then((value) => {
                    //if user not click the button in three
                    // seconds, this method does not delete annotation in firebase
                    if (!cancelRemove)
                      {
                        annotationController.removeAnnotation(
                            uid: snapshot.data!['${index}a']['uid'],
                            context: context)
                      }
                  });
              AnnotationsController.map.remove(index);
              final snackBar = SnackBar(
                padding: EdgeInsets.all(10),
                backgroundColor: Colors.purple,
                content: Text(
                  "Anotação removida!",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: "Desfazer",
                  onPressed: () {
                    cancelRemove = true;
                    annotationController.recoverAnnotation(
                        map: snapshot.data!['${index}a']);
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
                                '${snapshot.data!['${index}a']['title']}',
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
                                  child:
                                      Image.asset('assets/images/foguete.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${snapshot.data!['${index}a']['annotation']}',
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
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red))),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            onPressed: () {
                              alertDialogCreateAnnotation(
                                  context: context,
                                  initialValueAnnotation: snapshot.data!['${index}a']['annotation'],
                                  initialValueTitle: snapshot.data!['${index}a']['title'],
                                  function: () {
                                    annotationController.editAnnotation(
                                        uid: snapshot.data!['${index}a']['uid'],
                                        context: context,
                                        index: index);
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
      ),
    );
  }
}
