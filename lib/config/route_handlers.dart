import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/collections/collections.dart';
import '../pages/collections/create.dart';
import '../pages/collection_detail/collection_tabs.dart';
import '../pages/auth/auth.dart';
import '../scoped_models/collection.dart';
import '../scoped_models/collection_item.dart';
import '../pages/collection_detail/edit_collection_item.dart';
import '../pages/tags/tags.dart';
import '../scoped_models/item_tag.dart';

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
  var model2 = CollectionModel.of(context);
  return EditCollectionItemPage(collectionItemModel: model, collectionModel: model2);
});

var createCollectionItemHandler = Handler(
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


var tagsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var model = ItemTagModel.of(context);
  return TagsPage(model);
});
