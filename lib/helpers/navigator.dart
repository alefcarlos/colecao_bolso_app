import 'package:flutter/material.dart';

class NavigatorHelpers {
  static Future<T> push<T extends Widget>(BuildContext context, T page,
      {replace = false}) {
    if (replace) {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ));
    }

    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
