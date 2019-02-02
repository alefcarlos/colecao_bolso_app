import 'dart:async';
import 'collection_model.dart';

class CollectionsService {
  Future<List<Collection>> fetch() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Collection.withId(1, isFav: true, name: 'alef', itemCount: 10),
    ];
  }
}
