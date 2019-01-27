import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import './loading_model.dart';
import '../models/collection.dart';

class CollectionModel extends LoadingModel {
  List<Collection> _data = [];

  List<Collection> get collections => List.from(_data);

  deleteCollection(int index) {
    _data.removeAt(index);
    notifyListeners();
  }

  toggleFav(int index) {
    var model = _data[index];
    var newOne = Collection(
      itemCount: model.itemCount,
      name: model.name,
      isFav: !model.isFav,
    );

    newOne.setId(model.id);
    _data.removeAt(index);
    _data.add(newOne);

    _data.sort((a, b) => a.id.compareTo(b.id));

    notifyListeners();
  }

  addCollection(Collection entity) {
    entity.setId(_data.length + 1);
    _data.add(entity);

    notifyListeners();
  }

  fetch() {
    setLoading(true);

    Future.delayed(const Duration(seconds: 5), () => "5").then((value) {
      _data.add(Collection.withId(1, isFav: true, name: 'alef', itemCount: 10));
      setLoading(false);
    });
  }

  static CollectionModel of(BuildContext context) =>
      ScopedModel.of<CollectionModel>(context, rebuildOnChange: true);
}
