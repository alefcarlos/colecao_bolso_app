import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './collections_page.dart';
import './create.dart';
import 'collection_scoped_model.dart';

class CollectionsRoute {
  static String collectionsRoute = '/collections';
  static String createCollectionRoute = '/collections/create';

  static final collectionsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var model = CollectionModel.of(context);

    return CollectionsPage(model);
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
