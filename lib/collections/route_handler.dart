import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './collections_page.dart';
import './create.dart';
import 'bloc/bloc.dart';

class CollectionsRoute {
  static String collectionsRoute = '/collections';
  static String createCollectionRoute = '/collections/create';

  static final collectionsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {

    var tagsBloc = BlocProvider.of<CollectionsBloc>(context);
    
    tagsBloc.dispatch(CollectionsFetchEvent());

    return CollectionsPage(tagsBloc);
  });

  static final createCollectionHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CreateCollectionPage();
  });

  static void configureRoutes(Router router) {
    router.define(collectionsRoute, handler: collectionsHandler);
    router.define(createCollectionRoute, handler: createCollectionHandler);
  }
}
