import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  void pageTransition({required String route, required BuildContext context}) {
    Navigator.of(context).pushNamed(route);
  }

  Future<bool> finishAndPageTransition(
      {required String route, required BuildContext context}) async {
    try {
      await Navigator.of(context).popAndPushNamed(route);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class DisposableWidget {
  List<StreamSubscription> _subscriptions = [];

  void cancelSubscriptions() {
    _subscriptions.forEach((subscription) {
      subscription.cancel();
    });
  }

  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}

extension DisposableStreamSubscriton on StreamSubscription {
  void canceledBy(DisposableWidget widget) {
    widget.addSubscription(this);
  }
}
