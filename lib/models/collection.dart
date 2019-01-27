import 'package:flutter/material.dart';

class Collection {
  int _id;
  final String name;
  final bool isFav;
  final int itemCount;

  Collection({@required this.name, this.isFav, this.itemCount});
  Collection.withId(this._id, {@required this.name, this.isFav, this.itemCount});

  int get id => _id;
  setId(int id) => this._id = id;
}
