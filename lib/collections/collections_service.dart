import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../config/application.dart';

import 'collection_model.dart';

class CollectionsService {
  final http.Client httpClient;
  CollectionsService({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Collection>> fetch(int startIndex, int limit) async {
    final response = await httpClient.get('${Application.apiUri}/collections?_start=$startIndex&_limit=$limit');

    if (response.statusCode != 200)
      throw 'Não foi possível recuperar as coleções, tente novamente.';

    final data = json.decode(response.body) as List;
    return data.map((item) => Collection.fromMap(item)).toList();
  }
}