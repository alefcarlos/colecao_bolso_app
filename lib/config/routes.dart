import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/collections/collections.dart';
import '../pages/collections/create.dart';
import '../pages/collection_detail/collection_tabs.dart';
import '../entities/collectionEntity.dart';
import '../pages/auth/auth.dart';

class Routes {
  static String root = '/';
  static String collectionsRoute = '/collections';
  static String collectionItemsRoute = '/collection/:id';
  static String createCollectionRoute = '/collection/create';

  static void configureRoutes(Router router, List<CollectionEntity> collections,
      Function deleteCollectionFunc, Function createCollectionFunc) {
    var collectionsHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CollectionsPage(collections, deleteCollectionFunc);
    });

    var collectionItemsHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      var index = int.parse(params['id']?.first);

      return CollectionPage(collections, index);
    });

    var createCollectionHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CreateCollectionPage(createCollectionFunc);
    });

    var authHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AuthPage(collections, deleteCollectionFunc);
    });

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
