import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './fancy_fab.dart';
import '../../scoped_models/collection.dart';
import '../../config/application.dart';
import '../../models/collection.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CollectionsPage extends StatelessWidget {
  Widget _buildList(List<Collection> collections, Function deleteCollection, Function toggleFav) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          _buildListTile(collections, context, index, deleteCollection,toggleFav),
      itemCount: collections.length,
    );
  }

  Future<bool> _showConfirmDeletion(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirma a exclusão desssa coleção ?'),
          content: Text(
              'A coleção assim como todos os seus itens serão excluídos permanentimente!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text('Excluir'),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        );
      },
    );
  }


  Widget _buildListTile(List<Collection> collections, BuildContext context,
      int index, Function deleteCollection, Function toggleFav) {
    var item = collections[index];

    return Slidable(
      key: Key(item.id.toString()),
      delegate: SlidableBehindDelegate(),
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
          onDismissed: (actionType) {
            if (actionType == SlideActionType.secondary)
              deleteCollection(index);
          },
          dismissThresholds: <SlideActionType, double>{
            SlideActionType.primary: 1.0
          },
          onWillDismiss: (actionType) => _showConfirmDeletion(context, index)),
      actionExtentRatio: 0.25,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
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
              // trailing: _buildButtonBar(context, index, deleteCollection),
            )
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: item.isFav ? 'Desmarcar favorito' : 'Marcar favorito',
          color: Colors.indigo,
          icon: item.isFav ? Icons.favorite_border : Icons.favorite,
          onTap: () => toggleFav(index),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Excluir coleção',
          color: Colors.red,
          icon: Icons.delete_forever,
          onTap: () => null,
        ),
      ],
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
        ? _buildList(collections, model.deleteCollection, model.toggleFav)
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
