import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../models/collection_item.dart';

class CollectionItemModel extends Model {
  List<CollectionItem> _data = [];

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

  static CollectionItemModel of(BuildContext context) =>
      ScopedModel.of<CollectionItemModel>(context, rebuildOnChange: true);
}
