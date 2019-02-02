import 'package:flutter/material.dart';

class CollectionItem {
  int _id;
  final int collectionId;
  final String number;
  final bool isFav;
  final int quantity;
  final List<String> tags;

  CollectionItem(
      {@required this.collectionId,
      @required this.number,
      this.isFav = false,
      this.quantity = 1,
      this.tags});

  int get id => _id;
  setId(int id) => this._id = id;
}
