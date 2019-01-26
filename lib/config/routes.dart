import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/collections/collections.dart';
import '../pages/collections/create.dart';
import '../pages/collection_detail/collection_tabs.dart';
import '../entities/collectionEntity.dart';

class Routes {
  static String root = '/';
  static String collectionItems = '/collection/:id';
  static String createCollection = '/collection/create';

  static void configureRoutes(Router router, List<CollectionEntity> collections,
      Function deleteCollectionFunc, Function createCollectionFunc) {
    var rootHandler = Handler(
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

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: rootHandler);
    router.define(createCollection, handler: createCollectionHandler);
    router.define(collectionItems, handler: collectionItemsHandler);
  }
}
