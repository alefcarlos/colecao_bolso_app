import 'package:fluro/fluro.dart';
import '../collections/collection_model.dart';
import '../collection/collection_item_model.dart';

class Application {
  static Router router;
  static final String apiUri = "https://my-json-server.typicode.com/alefcarlos/colecao_bolso_app/";
  static final List<Collection> collections = [];
  static final List<CollectionItem> collectionItems = [];
}