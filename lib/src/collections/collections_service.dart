// import 'dart:convert';
import 'dart:async';
import 'package:colecao_bolso_app/application/service/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../config/application.dart';
import 'collection_model.dart';

class CollectionsService extends ServiceBase {
  final http.Client httpClient;
  CollectionsService({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Collection>> fetch(int startIndex, int limit) async {
    await Future.delayed(Duration(seconds: 1));
    // final response = await httpClient.get(
    //     '${Application.apiUri}/collections?_start=$startIndex&_limit=$limit');

    // if (response.statusCode != 200)
    //   throw 'Não foi possível recuperar as coleções, tente novamente.';
    if (Application.collections.isEmpty) return [];

    return Application.collections.skip(startIndex).take(limit).toList();
    // final data = json.decode(response.body) as List;
    // return data.map((item) => Collection.fromMap(item)).toList();
  }

  Future<void> delete(int collectionId) async {
    await Future.delayed(Duration(seconds: 1));
    // final response = await httpClient
    //     .delete('${Application.apiUri}/collections/$collectionId');

    // if (response.statusCode != 200)
    //   throw 'Não foi possível deletar a coleção, tente novamente.';

    var index = Application.collections.indexWhere((c) => c.id == collectionId);
    Application.collections.removeAt(index);
  }

  Future<void> toggleFav(int collectionId) async {
    await Future.delayed(Duration(seconds: 1));

    var index = Application.collections.indexWhere((c) => c.id == collectionId);
    Application.collections[index]
        .setFav(!Application.collections[index].isFav);

    // final response = await httpClient
    //     .put('${Application.apiUri}/collections/$collectionId', {isFav: false});

    // if (response.statusCode != 200)
    //   throw 'Não foi possível deletar a coleção, tente novamente.';
  }

  Future<void> add(Collection model) async {
    await Future.delayed(Duration(seconds: 1));
    // var response = await httpClient.post('${Application.apiUri}/collections/',
    //     body: json.encode(model.toMap()));

    // if (response.statusCode != 201)
    //   throw 'Não foi possível criar a coleção, tente novamente.';

    model.setId(Application.collections.length + 1);
    Application.collections.add(model);
  }

  Future<List<Collection>> fetchAll() async {
    await Future.delayed(Duration(seconds: 1));

    return Application.collections;
    // final response = await httpClient.get('${Application.apiUri}/collections');

    // if (response.statusCode != 200)
    //   throw 'Não foi possível recuperar as coleções, tente novamente.';

    // final data = json.decode(response.body) as List;
    // return data.map((item) => Collection.fromMap(item)).toList();
  }

  Future<List<Collection>> search(String term) async {
    await Future.delayed(Duration(seconds: 1));

    return Application.collections
        .where((col) => col.name.contains(term.trim()))
        .toList();
  }

  static CollectionsService of(BuildContext context) =>
      ServiceProvider.of<CollectionsService>(context);
}
