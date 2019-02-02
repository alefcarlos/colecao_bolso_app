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

  static Future<T> pushNamed<T extends Widget>(
      BuildContext context, String route,
      {replace = false}) {
    if (replace) return Navigator.pushReplacementNamed(context, route);

    return Navigator.pushNamed(context, route);
  }
}
