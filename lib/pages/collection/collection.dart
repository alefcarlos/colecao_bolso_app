import 'package:flutter/material.dart';
import '../../data.dart';

class CollectionPage extends StatelessWidget {
  final int index;
  final int collectionId;

  CollectionPage(this.index, this.collectionId);

  @override
  Widget build(BuildContext context) {
    var collection = DataHelpers.tempData[index];

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(collection.name),
        ),
        body: Center(
          child: Text(collection.name),
        ),
      ),
    );
  }
}