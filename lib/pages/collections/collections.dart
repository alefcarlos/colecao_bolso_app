import 'package:flutter/material.dart';
import './fancy_fab.dart';
import '../../entities/collectionEntity.dart';
import '../../helpers/navigator.dart';
import '../collection/collection.dart';

class CollectionsPage extends StatelessWidget {
  final List<CollectionEntity> collections;

  CollectionsPage(this.collections);

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: _buildListTile,
      itemCount: collections.length,
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    var item = collections[index];
    return ListTile(
      onTap: () => NavigatorHelpers.push(context, CollectionPage(index, item.id)),
      title: Text(item.name),
      trailing: Icon(
        item.isFav ? Icons.favorite : Icons.favorite_border,
        color: item.isFav ? Colors.red : null,
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há coleções cadastradas.'),
    );
  }

  Widget _buildDisplay() {
    return (collections.length > 0) ? _buildList() : _buildEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Minhas coleções'),
      ),
      body: _buildDisplay(),
      floatingActionButton: CollectionsPageFab(),
    );
  }
}
