import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './collections_page.dart';
import './create.dart';
import 'bloc/list/exporter.dart';
import 'bloc/create/exporter.dart';

class CollectionsRoute {
  static String collectionsRoute = '/collections';
  static String createCollectionRoute = '/collections/create';

  static final collectionsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var bloc = CollectionsBloc.of(context);

    bloc.dispatch(CollectionsFetchEvent());

    return CollectionsPage(bloc);
  });

  static final createCollectionHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {

    var bloc = CreateCollectionBloc.of(context);
    return CreateCollectionPage(bloc);
  });

  static void configureRoutes(Router router) {
    router.define(collectionsRoute, handler: collectionsHandler);
    router.define(createCollectionRoute, handler: createCollectionHandler);
  }
}
