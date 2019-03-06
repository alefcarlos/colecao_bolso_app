import 'package:flutter/material.dart';
import 'bloc/create/exporter.dart';
import 'create_form.dart';

class CreateCollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nova Coleção'),
        ),
        body: CollectionCreateForm(CreateCollectionBloc.of(context)));
  }
}
