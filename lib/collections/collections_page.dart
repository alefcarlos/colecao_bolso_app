import 'package:flutter/material.dart';

import './fancy_fab.dart';
import './collection_scoped_model.dart';
import 'drawer.dart';
import 'collections_list.dart';
import 'bloc/bloc.dart';

class CollectionsPage extends StatelessWidget {
  final CollectionModel collectionModel;
  final  CollectionsBloc collectionsBloc;

  CollectionsPage(this.collectionModel, this.collectionsBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CollectionsDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Minhas coleções'),
      ),
      // body:  Shimmers.listView(context),
      body: CollectionsList(collectionModel, collectionsBloc),
      floatingActionButton: CollectionsPageFab(),
    );
  }
}
