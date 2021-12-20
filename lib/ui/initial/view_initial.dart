import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewInitial extends StatelessWidget {
  const ViewInitial({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(InitialController());
    return GetBuilder<InitialController>(
      builder: (_) => FutureBuilder(
        future: _.splashScreen(context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return LayoutBuilder(
            builder: (_, constraints) {
              return Container(
                color: Colors.purple,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/foguete.png',
                          width: constraints.maxWidth * 0.25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WidgetProgress(colors: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
