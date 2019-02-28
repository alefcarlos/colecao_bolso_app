import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

void showSnackBar(BuildContext context, String text, {SnackBarAction action}) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: new Text(text), action: action));
}

Future<File> cropImage(
    {@required String path,
    String title = "Cartar imagem",
    int maxWidth,
    int maxHeight,
    bool fixedRatio = false,
    double ratio,
    MaterialColor toolbarColor = Colors.orange}) async {
  return await ImageCropper.cropImage(
    sourcePath: path,
    // ratioX: fixedRatio ? ratio : null,
    // ratioY: fixedRatio ? ratio : null,
    toolbarTitle: title,
    toolbarColor: toolbarColor,
  );
}
