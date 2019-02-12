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
  ];
  static final List<CollectionItem> collectionItems = [
    CollectionItem(1, "1", false, 2, null),
    CollectionItem(1, "3", true, 1, null),
  ];
}
