import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {SnackBarAction action}) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: new Text(text), action: action));
}
