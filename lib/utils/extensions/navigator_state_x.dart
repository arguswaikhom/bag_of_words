import 'package:flutter/material.dart';

extension NavigatorStateX on NavigatorState {
  Future<T?> pushAndRemoveAll<T extends Object?>(Route<T> newRoute) {
    return pushAndRemoveUntil(newRoute, (route) => false);
  }
}
