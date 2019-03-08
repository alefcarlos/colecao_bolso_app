import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'collection_page.dart';
import 'create/create_page.dart';
import '../config/application.dart';
import 'collection_detail_page.dart';

abstract class CollectionRoute {
  static String collectionItemsRoute = '/collection/:id';

  /// Rota /collection/item/create
  static String createItemRoute = '/collection/item/create';

  /// Rota /collection/25/item/create
  static String createCollectionItemRoute = '/collection/:id/item/create';

  static String collectionItemRoute = '/collection/item/:id';

  static final collectionItemsHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var collectionId = int.parse(params['id']?.first);
    var col =
        Application.collections.firstWhere((col) => col.id == collectionId);

    return CollectionPage(collectionId, col);
  });

  static final createItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CreateCollectionItemPage();
  });

  static final createCollectionItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var collectionId = int.parse(params['id']?.first);

    return CreateCollectionItemPage(collectionId: collectionId);
  });

  static final collectionItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var id = int.parse(params['id']?.first);
    var item = Application.collectionItems.firstWhere((item) => item.id == id);

    return CollectionDetailPage(item);
  });

  static void configureRoutes(Router router) {
    router.define(collectionItemsRoute, handler: collectionItemsHandler);
    router.define(createItemRoute, handler: createItemHandler);
    router.define(createCollectionItemRoute,
        handler: createCollectionItemHandler);
    router.define(collectionItemRoute, handler: collectionItemHandler);
  }
}
