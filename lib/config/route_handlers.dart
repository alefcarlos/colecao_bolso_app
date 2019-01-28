import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/collections/collections.dart';
import '../pages/collections/create.dart';
import '../pages/collection_detail/collection_tabs.dart';
import '../pages/auth/auth.dart';
import '../scoped_models/collection.dart';
import '../scoped_models/collection_item.dart';
import '../pages/collection_detail/edit_collection_item.dart';

var collectionsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var model = CollectionModel.of(context);

  return CollectionsPage(model);
});

var collectionItemsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var index = int.parse(params['id']?.first);

  return CollectionPage(index);
});

var createCollectionHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateCollectionPage();
});

var authHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AuthPage();
});

var createItemHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var model = CollectionItemModel.of(context);
  return EditCollectionItemPage(collectionItemModel: model);
});

var createCollectionItemHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var index = int.parse(params['id']?.first);

  var model = CollectionItemModel.of(context);
  return EditCollectionItemPage(
    collectionId: index,
    collectionItemModel: model,
  );
});
