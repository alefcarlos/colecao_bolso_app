import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'collection_item_model.dart';
import '../config/app_config.dart';

class CollectionService {
  final http.Client httpClient;

  CollectionService({@required this.httpClient}) : assert(httpClient != null);

  Future<List<CollectionItem>> fetch(
      int collectionId, int startIndex, int limit) async {
    await Future.delayed(Duration(seconds: 1));
    // final response = await httpClient.get(
    //     '${Application.apiUri}/collections?_start=$startIndex&_limit=$limit');

    // if (response.statusCode != 200)
    //   throw 'Não foi possível recuperar as coleções, tente novamente.';

    return Application.collectionItems
        .where((i) => i.collectionId == collectionId)
        .skip(startIndex)
        .take(limit)
        .toList();
    // final data = json.decode(response.body) as List;
    // return data.map((item) => Collection.fromMap(item)).toList();
  }

  Future<List<CollectionItem>> fetchFav(int collectionId) async {
    await Future.delayed(Duration(seconds: 1));

    return Application.collectionItems
        .where((i) => i.collectionId == collectionId && i.isFav)
        .toList();
  }

  Future<List<CollectionItem>> fetchRepeated(int collectionId) async {
    await Future.delayed(Duration(seconds: 1));

    return Application.collectionItems
        .where((i) => i.collectionId == collectionId && i.quantity > 1)
        .toList();
  }
}
