import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './tags_page.dart';
import './bloc/bloc.dart';

class TagsRoute {
  static String tags = '/tags';

  static final tagsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var tagsBloc = BlocProvider.of<TagsBloc>(context);
    
    tagsBloc.dispatch(TagsEvent.loading);
    return TagsPage(tagsBloc);
    // return TagsPage();
  });

  static void configureRoutes(Router router) {
    router.define(tags, handler: tagsHandler);
  }
}
