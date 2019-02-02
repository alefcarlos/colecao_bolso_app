import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './tags_page.dart';
import './tag_scoped_model.dart';

class TagsRoute {
  static String tags = '/tags';

  static final tagsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var model = ItemTagModel.of(context);
    return TagsPage(model);
  });

  static void configureRoutes(Router router) {
    router.define(tags, handler: tagsHandler);
  }
}
