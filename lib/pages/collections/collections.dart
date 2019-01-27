import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './fancy_fab.dart';
import '../../scoped_models/collection.dart';
import '../../config/application.dart';
import '../../models/collection.dart';

class CollectionsPage extends StatelessWidget {
  Widget _buildList(List<Collection> collections, Function deleteCollection) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          _buildListTile(collections, context, index, deleteCollection),
      itemCount: collections.length,
    );
  }

  _showConfirmDeletion(
      BuildContext context, int index, Function deleteCollection) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirma a exclusão desssa coleção ?'),
          content: Text(
              'A coleção assim como todos os seus itens serão excluídos permanentimente!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('Excluir'),
              onPressed: () {
                deleteCollection(index);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildListTileDismissBackground() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: Text(
        'Excluir coleção',
        textAlign: TextAlign.right,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
      ),
    );
  }

  Widget _buildButtonBar(
      BuildContext context, int index, Function deleteCollection) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
          tooltip: 'Excluir coleção',
          onPressed: () =>
              _showConfirmDeletion(context, index, deleteCollection),
        )
      ],
    );
  }

  Widget _buildListTile(List<Collection> collections, BuildContext context,
      int index, Function deleteCollection) {
    var item = collections[index];

    return Dismissible(
      key: Key(item.name),
      direction: DismissDirection.endToStart,
      background: _buildListTileDismissBackground(),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          deleteCollection(index);
        }
      },
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => Application.router.navigateTo(
                context, '/collection/$index',
                transition: TransitionType.inFromRight),
            title: Text(item.name),
            subtitle: Text('10 de ${item.itemCount}'),
            leading: Icon(
              item.isFav ? Icons.favorite : Icons.favorite_border,
              color: item.isFav ? Colors.red : null,
            ),
            trailing: _buildButtonBar(context, index, deleteCollection),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há coleções cadastradas.'),
    );
  }

  Widget _buildDisplay(BuildContext context) {
    var model = CollectionModel.of(context);
    var collections = model.collections;
    return (collections.length > 0)
        ? _buildList(collections, model.deleteCollection)
        : _buildEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Minhas coleções'),
      ),
      body: _buildDisplay(context),
      floatingActionButton: CollectionsPageFab(),
    );
  }
}
