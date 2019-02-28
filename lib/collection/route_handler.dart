import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'bloc/list/exporter.dart';
import 'bloc/fav/exporter.dart';
import 'bloc/repeated/exporter.dart';

import 'collection_page.dart';
import 'create/create.dart';

class CollectionRoute {
  static String collectionItemsRoute = '/collection/:id';

  /// Rota /collection/item/create
  static String createItemRoute = '/collection/item/create';

  /// Rota /collection/25/item/create
  static String createCollectionItemRoute = '/collection/:id/item/create';

  static final collectionItemsHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var collectionId = int.parse(params['id']?.first);
    var bloc = CollectionBloc.of(context);
    var favBloc = CollectionFavItemsBloc.of(context);
    var repeatedBloc = CollectionRepeatedItemsBloc.of(context);

    return CollectionPage(collectionId, bloc, repeatedBloc, favBloc);
  });

  static final createItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {

    return EditCollectionItemPage(collectionItemModel: null);
  });

  static final createCollectionItemHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var index = int.parse(params['id']?.first);

    return EditCollectionItemPage(
        collectionId: index, collectionItemModel: null);
  });

  static void configureRoutes(Router router) {
    router.define(collectionItemsRoute, handler: collectionItemsHandler);
    router.define(createItemRoute, handler: createItemHandler);
    router.define(createCollectionItemRoute,
        handler: createCollectionItemHandler);
  }
}
