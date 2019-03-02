import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'collection_page.dart';
import 'create/create_page.dart';

class CollectionRoute {
  static String collectionItemsRoute = '/collection/:id';

  /// Rota /collection/item/create
  static String createItemRoute = '/collection/item/create';

  /// Rota /collection/25/item/create
  static String createCollectionItemRoute = '/collection/:id/item/create';

  static final collectionItemsHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var collectionId = int.parse(params['id']?.first);

    return CollectionPage(collectionId);
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

  static void configureRoutes(Router router) {
    router.define(collectionItemsRoute, handler: collectionItemsHandler);
    router.define(createItemRoute, handler: createItemHandler);
    router.define(createCollectionItemRoute,
        handler: createCollectionItemHandler);
  }
}
