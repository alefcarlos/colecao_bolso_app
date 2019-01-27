import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../models/collection_item.dart';

class CollectionItemModel extends Model {
  List<CollectionItem> _data = [
    CollectionItem(collectionId: 1, isFav: true, number: "1", quantity: 5),
    CollectionItem(collectionId: 1, isFav: false, number: "2", quantity: 1),
    CollectionItem(collectionId: 1, isFav: false, number: "3", quantity: 3),
    CollectionItem(collectionId: 1, isFav: true, number: "4", quantity: 1),
  ];

  List<CollectionItem> get collectionsItems => List.from(_data);

  // deleteCollection(index) {
  //   _collections.removeAt(index);
  //   notifyListeners();
  // }

  addCollectionItem(int collectionId, CollectionItem entity) {
    entity.setId(_data.length + 1);
    _data.add(entity);

    notifyListeners();
  }

  List<CollectionItem> getItems(int collectionId) => collectionsItems
      .where((CollectionItem item) => item.collectionId == collectionId)
      .toList();

  List<CollectionItem> getFavItems(int collectionId) => collectionsItems
      .where((CollectionItem item) =>
          item.collectionId == collectionId && item.isFav)
      .toList();

  List<CollectionItem> getRepeatedItems(int collectionId) => collectionsItems
      .where((CollectionItem item) =>
          item.collectionId == collectionId && item.quantity > 1)
      .toList();

  static CollectionItemModel of(BuildContext context) =>
      ScopedModel.of<CollectionItemModel>(context, rebuildOnChange: true);
}
