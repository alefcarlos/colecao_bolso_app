import 'package:fluro/fluro.dart';
import '../collections/collection_model.dart';
import '../collection/collection_item_model.dart';

class Application {
  static Router router;
  static final String apiUri =
      "https://my-json-server.typicode.com/alefcarlos/colecao_bolso_app/";
  static final List<Collection> collections = [
    Collection(1, "primeira", true, 10),
    Collection(2, "primeira", true, 10),
    Collection(3, "primeira", false, 10),
    Collection(4, "primeira", true, 10),
    Collection(5, "primeira", true, 10),
    Collection(6, "primeira", true, 10),
    Collection(7, "primeira", true, 10),
    Collection(8, "primeira", true, 10),
    Collection(9, "primeira", true, 10),
    Collection(10, "primeira", false, 10),
    Collection(11, "primeira", true, 10),
    Collection(12, "primeira", true, 10),
    Collection(13, "primeira", true, 10),
    Collection(14, "primeira", true, 10),
    Collection(15, "primeira", false, 10),
    Collection(16, "primeira", true, 10),
    Collection(17, "primeira", false, 10),
    Collection(18, "primeira", true, 10),
    Collection(19, "primeira", true, 10),
    Collection(20, "primeira", true, 10),
    Collection(21, "primeira", true, 10),
    Collection(22, "primeira", true, 10),
    Collection(23, "primeira", true, 10),
    Collection(24, "primeira", false, 10),
    Collection(25, "primeira", true, 10),
    Collection(26, "primeira", true, 10),
    Collection(27, "primeira", true, 10),
  ];
  static final List<CollectionItem> collectionItems = [
    CollectionItem(collectionId: 1, number: "1", isFav: false, quantity: 2),
    CollectionItem(collectionId: 1, number: "3", isFav: true, quantity: 1),
  ];
}
