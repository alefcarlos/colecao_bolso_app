import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'collection_page.dart';
import 'collection_item_scoped_model.dart';
import 'edit_collection_item_page.dart';
import '../collections/collection_scoped_model.dart';

class CollectionRoute {
  static String collectionItemsRoute = '/collection/:id';
  
  /// Rota /collection/item/create
  static String createItemRoute = '/collection/item/create';

  /// Rota /collection/25/item/create
  static String createCollectionItemRoute = '/collection/:id/item/create';

  static final collectionItemsHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var index = int.parse(params['id']?.first);

    return CollectionPage(index);
  });

  static final createItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var model = CollectionItemModel.of(context);
    var model2 = CollectionModel.of(context);
    return EditCollectionItemPage(
        collectionItemModel: model, collectionModel: model2);
  });

  static final createCollectionItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var index = int.parse(params['id']?.first);

    var model = CollectionItemModel.of(context);
    var model2 = CollectionModel.of(context);

    return EditCollectionItemPage(
      collectionId: index,
      collectionItemModel: model,
      collectionModel: model2,
    );
  });

  static void configureRoutes(Router router) {
    router.define(collectionItemsRoute, handler: collectionItemsHandler);
    router.define(createItemRoute, handler: createItemHandler);
    router.define(createCollectionItemRoute,
        handler: createCollectionItemHandler);
  }
}
