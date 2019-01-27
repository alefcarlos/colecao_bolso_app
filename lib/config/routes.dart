import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String collectionsRoute = '/collections';
  static String collectionItemsRoute = '/collection/:id';
  static String createCollectionRoute = '/collection/create';

  static void configureRoutes(Router router) {

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: authHandler);
    router.define(collectionsRoute, handler: collectionsHandler);
    router.define(createCollectionRoute, handler: createCollectionHandler);
    router.define(collectionItemsRoute, handler: collectionItemsHandler);
  }
}
