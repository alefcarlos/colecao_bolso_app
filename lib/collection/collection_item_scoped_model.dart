import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import './collection_item_model.dart';
import '../scoped_models/scoped_models.dart';

class CollectionItemModel extends LoadingModel {
  List<CollectionItem> _data = [];

  List<CollectionItem> get collectionsItems => List.from(_data);

  deleteCollectionItem(index) {
    _data.removeAt(index);

    notifyListeners();
  }

  addCollectionItem(int collectionId, CollectionItem entity) {
    entity.setId(_data.length + 1);
    _data.add(entity);

    notifyListeners();
  }

  toggleFav(int collectionId, int index, int collectionItemId) {
    var model = _data.firstWhere((d) => d.collectionId == collectionId && d.id == collectionItemId);
    var newOne = CollectionItem(
        number: model.number,
        quantity: model.quantity,
        collectionId: model.collectionId,
        isFav: !model.isFav,
        tags: model.tags);
    newOne.setId(model.id);
    _data.remove(model);
    _data.add(newOne);
    _data.sort((a, b) => a.number.compareTo(b.number));

    notifyListeners();
  }

  List<CollectionItem> getItems(int collectionId) {
    var result = _data
        .where((CollectionItem item) => item.collectionId == collectionId)
        .toList();

    result.sort((a, b) => a.number.compareTo(b.number));

    return result;
  }

  List<CollectionItem> getFavItems(int collectionId) {
    var result = _data
        .where((CollectionItem item) =>
            item.collectionId == collectionId && item.isFav)
        .toList();

    result.sort((a, b) => a.number.compareTo(b.number));

    return result;
  }

  List<CollectionItem> getRepeatedItems(int collectionId) {
    var result = _data
        .where((CollectionItem item) =>
            item.collectionId == collectionId && item.quantity > 1)
        .toList();

    result.sort((a, b) => a.number.compareTo(b.number));

    return result;
  }

  Future fetch(int collectionId) {
    setLoading(true);

    return Future.delayed(const Duration(seconds: 1), () => "5").then((value) {
      if (_data.length == 0) {
        _data.addAll([
          CollectionItem(
              collectionId: 1, isFav: true, number: "1", quantity: 5),
          CollectionItem(
              collectionId: 1, isFav: false, number: "2", quantity: 1),
          CollectionItem(
              collectionId: 1, isFav: false, number: "3", quantity: 3),
          CollectionItem(
              collectionId: 1, isFav: true, number: "4", quantity: 1),
        ]);
      }

      setLoading(false);
    });
  }

  static CollectionItemModel of(BuildContext context) =>
      ScopedModel.of<CollectionItemModel>(context, rebuildOnChange: true);
}
