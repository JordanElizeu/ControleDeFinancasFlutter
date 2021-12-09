import 'dart:ui';

import 'package:app_financeiro/ui/initial/widgets/widget_textinformative.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.purple,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.30,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            child: Icon(
                              Icons.person_outline,
                              size: 25,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.info_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      textInformative(text: 'Olá, user', fontSize: 20.0)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textInformative(text: 'Conta', fontSize: 20.0),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                    textInformative(
                        text: 'R\$ 0',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        circleAvatar(
                            iconData: Icons.arrow_circle_up_rounded,
                            text: "Depositar"),
                        circleAvatar(
                            iconData: Icons.arrow_circle_down, text: "Retirar"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget circleAvatar({@required IconData iconData, @required String text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0),
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black12,
          child: Icon(iconData,size: 40.0,color: Colors.black54,),
          radius: 40.0,
        ),
        Text(text)
      ],
    ),
  );
}
