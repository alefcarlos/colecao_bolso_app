import 'package:flutter/material.dart';
import './fancy_fab.dart';
import '../../entities/collectionEntity.dart';
import '../../helpers/navigator.dart';
import '../collection/collection_tabs.dart';

class CollectionsPage extends StatelessWidget {
  final List<CollectionEntity> collections;
  final Function deleteCollection;

  CollectionsPage(this.collections, this.deleteCollection);

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: _buildListTile,
      itemCount: collections.length,
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    var item = collections[index];

    return ListTile(
      onTap: () =>
          NavigatorHelpers.push(context, CollectionPage(collections, index, item.id)),
      title: Text(item.name),
      subtitle: Text('10 de 3'),
      leading: Icon(
        item.isFav ? Icons.favorite : Icons.favorite_border,
        color: item.isFav ? Colors.red : null,
      ),
      trailing: ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            onPressed: () => deleteCollection(index),
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          )
        ],
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
