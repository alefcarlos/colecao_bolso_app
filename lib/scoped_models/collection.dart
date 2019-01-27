import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../models/collection.dart';

class CollectionModel extends Model {
  List<Collection> _data = [];

  List<Collection> get collections => List.from(_data);

  deleteCollection(index) {
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

    _data.sort((a,b) => a.id.compareTo(b.id));

    notifyListeners();
  }

  addCollection(Collection entity) {
    entity.setId(_data.length + 1);
    _data.add(entity);

    notifyListeners();
  }

  static CollectionModel of(BuildContext context) =>
      ScopedModel.of<CollectionModel>(context, rebuildOnChange: true);
}
