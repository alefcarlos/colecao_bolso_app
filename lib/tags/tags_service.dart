import 'dart:async';
import 'tag_model.dart';

class TagsService {
  Future<List<ItemTag>> fetch() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      ItemTag('books', 10),
      ItemTag('avenda', 50),
      ItemTag('mangá', 20),
      ItemTag('outra tag', 14),
      ItemTag('tenis', 13),
      ItemTag('camisas', 45),
      ItemTag('maratona', 39),
      ItemTag('tag2', 40),
    ];
  }
}
