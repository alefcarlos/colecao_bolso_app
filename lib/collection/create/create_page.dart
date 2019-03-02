import 'package:flutter/material.dart';
import 'create_form.dart';
import '../bloc/create/exporter.dart';

class CreateCollectionItemPage extends StatelessWidget {
  /// É possível criamos um item para uma determinada coleção, basta informar o ID da mesma
  final int collectionId;

  CreateCollectionItemPage({this.collectionId});

  @override
  Widget build(BuildContext context) {
    var bloc = CreateCollectionItemBloc.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo item'),
      ),
      body: CreateCollectionItemForm(collectionId, bloc),
    );
  }
}
