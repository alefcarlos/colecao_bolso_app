import 'package:flutter/material.dart';

import './fancy_fab.dart';
import 'drawer.dart';
import 'collections_list.dart';
import 'bloc/list/exporter.dart';

class CollectionsPage extends StatelessWidget {
  final CollectionsBloc collectionsBloc;

  CollectionsPage(this.collectionsBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CollectionsDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Minhas coleções'),
      ),
      body: CollectionsList(collectionsBloc),
      floatingActionButton: CollectionsPageFab(collectionsBloc),
    );
  }
}
