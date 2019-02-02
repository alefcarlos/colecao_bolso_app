import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../config/application.dart';

import 'tag_model.dart';

class TagsService {
  final http.Client httpClient;
  TagsService({@required this.httpClient}) : assert(httpClient != null);

  Future<List<ItemTag>> fetch(int limit) async {
    final response = await httpClient.get('${Application.apiUri}/tags?limit=$limit');

    if (response.statusCode != 200)
      throw 'Não foi possível recuperar as tags, tente novamente.';

    final data = json.decode(response.body) as List;
    return data.map((item) => ItemTag.fromMap(item)).toList();
  }
}
