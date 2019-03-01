import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './tags_page.dart';

class TagsRoute {
  static String tags = '/tags';

  static final tagsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return TagsPage();
  });

  static void configureRoutes(Router router) {
    router.define(tags, handler: tagsHandler);
  }
}
