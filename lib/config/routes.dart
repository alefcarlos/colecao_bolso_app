import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/collections/collections.dart';
import '../pages/collection/collection_tabs.dart';
import '../entities/collectionEntity.dart';

class Routes {
  static String root = '/';
  static String collectionItems = '/collection/:id';

  static void configureRoutes(Router router, List<CollectionEntity> collections,
      Function deleteCollection) {
    var rootHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CollectionsPage(collections, deleteCollection);
    });

    var collectionItemsHandlers = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          var index = int.parse(params['id']?.first);

      return CollectionPage(collections, index);
    });

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: rootHandler);
    router.define(collectionItems, handler: collectionItemsHandlers);
  }
}
