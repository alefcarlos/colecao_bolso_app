import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../models/collection.dart';

class CollectionModel extends Model {
  List<Collection> _collections = [];

  List<Collection> get collections => List.from(_collections);

  deleteCollection(index) {
    _collections.removeAt(index);
    notifyListeners();
  }

  addCollection(Collection entity) {
    entity.setId(_collections.length + 1);
    _collections.add(entity);

    notifyListeners();
  }

  static CollectionModel of(BuildContext context) =>
      ScopedModel.of<CollectionModel>(context, rebuildOnChange: true);
}
