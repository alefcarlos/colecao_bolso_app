import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './loading_model.dart';
import '../models/item_tag.dart';

class ItemTagModel extends LoadingModel {
  List<ItemTag> _data = [];

  List<ItemTag> get tags => List.from(_data);

  Future fetch() {
    setLoading(true);

    return Future.delayed(const Duration(seconds: 1), () => "5").then((value) {
      if (_data.length == 0) {
        _data.addAll([
          ItemTag('books', 10),
          ItemTag('avenda', 50),
          ItemTag('mangá', 20),
          ItemTag('outra tag', 14),
          ItemTag('tenis', 13),
          ItemTag('camisas', 45),
          ItemTag('maratona', 39),
          ItemTag('tag2', 40),
        ]);
      }

      setLoading(false);
    });
  }

  static ItemTagModel of(BuildContext context) =>
      ScopedModel.of<ItemTagModel>(context, rebuildOnChange: true);
}
