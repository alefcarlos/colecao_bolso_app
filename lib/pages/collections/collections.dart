import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './fancy_fab.dart';
import '../../entities/collectionEntity.dart';
import '../../config/application.dart';

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

  _showConfirmDeletion(BuildContext context, int index) {
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

  Widget _buildButtonBar(BuildContext context, int index) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
          tooltip: 'Excluir coleção',
          onPressed: () => _showConfirmDeletion(context, index),
        )
      ],
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
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
            trailing: _buildButtonBar(context, index),
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
