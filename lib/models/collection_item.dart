import 'package:flutter/material.dart';


class CollectionItem {
  int _id;
  String number;

  CollectionItem({@required this.number});

  int get id => _id;
  setId(int id) => this._id = id;
}