import 'package:flutter/material.dart';

class Collection {
  int _id;
  final String name;
  final bool isFav;
  final int itemCount;

  Collection({@required this.name, @required this.isFav, @required this.itemCount});

  int get id => _id;
  setId(int id) => this._id = id;
}
