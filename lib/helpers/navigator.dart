import 'package:flutter/material.dart';

class NavigatorHelpers {
  static Future<T> pushMaterialRoute<T extends Widget>(
      BuildContext context, T page) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
