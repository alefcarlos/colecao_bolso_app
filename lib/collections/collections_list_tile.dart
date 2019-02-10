import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../common/common.dart';
import '../config/app_config.dart';
import 'collection_model.dart';
import 'bloc/list/exporter.dart';

class CollectionsListTile extends StatelessWidget {
  final Collection _collection;
  final CollectionsBloc _collectionsBloc;
  final SlidableController slidableController = new SlidableController();

  CollectionsListTile(this._collection, this._collectionsBloc)
      : assert(_collection != null),
        assert(_collectionsBloc != null);

  @override
  Widget build(BuildContext context) {
    var color = _collection.rgbColor.split(',');

    return Slidable(
      controller: slidableController,
      key: Key(_collection.id.toString()),
      delegate: SlidableBehindDelegate(),
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (actionType) {
          if (actionType == SlideActionType.secondary) {
            _collectionsBloc.dispatch(CollectionsDeleteEvent(_collection.id));
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
              trailing: Icon(
                Icons.label,
                color: Color.fromARGB(
                  255,
                  int.parse(color[0]),
                  int.parse(color[1]),
                  int.parse(color[2]),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: _collection.isFav ? 'Desmarcar favorito' : 'Marcar favorito',
          color: Colors.indigo,
          icon: _collection.isFav ? Icons.favorite_border : Icons.favorite,
          onTap: () {
            _collectionsBloc
                .dispatch(CollectionsToggleFavEvent(_collection.id));
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Excluir coleção',
          color: Colors.red,
          icon: Icons.delete_forever,
          closeOnTap: false,
          onTap: () async {
            if (await _showConfirmDeletion(context)) {
              _collectionsBloc.dispatch(CollectionsDeleteEvent(_collection.id));
              showSnackBar(context, 'Exclusão realizada com sucesso!');
            }
          },
        ),
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
