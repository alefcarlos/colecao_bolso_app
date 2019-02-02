import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../common/common.dart';
import '../config/app_config.dart';
import 'collection_model.dart';

class CollectionsListTile extends StatelessWidget {
  final Collection _collection;

  CollectionsListTile(this._collection) : assert(_collection != null);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(_collection.id.toString()),
      delegate: SlidableBehindDelegate(),
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (actionType) {
          if (actionType == SlideActionType.secondary) {
            //TODO: deletar coleção
            // widget.collectionModel.deleteCollection(index);
          }
        },
        dismissThresholds: <SlideActionType, double>{
          SlideActionType.primary: 1.0
        },
        onWillDismiss: (actionType) => _showConfirmDeletion(context),
      ),
      actionExtentRatio: 0.25,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () => Application.router.navigateTo(
                  context, '/collection/${_collection.id}',
                  transition: TransitionType.inFromRight),
              title: Text(_collection.name),
              subtitle: Text('10 de ${_collection.itemCount}'),
              leading: Icon(
                _collection.isFav ? Icons.favorite : Icons.favorite_border,
                color: _collection.isFav ? Colors.red : null,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: _collection.isFav ? 'Desmarcar favorito' : 'Marcar favorito',
          color: Colors.indigo,
          icon: _collection.isFav ? Icons.favorite_border : Icons.favorite,
          onTap: () {
            //TODO: funcionalidade de marcar favorito
            // widget.collectionModel.toggleFav(index);
            showSnackBar(context, 'Ação realizada com sucesso!');
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Excluir coleção',
            color: Colors.red,
            icon: Icons.delete_forever),
      ],
    );
  }

  Future<bool> _showConfirmDeletion(BuildContext context) {
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
}
