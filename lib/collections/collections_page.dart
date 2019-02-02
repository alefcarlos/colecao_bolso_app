import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import './fancy_fab.dart';

import './collection_scoped_model.dart';
import '../config/app_config.dart';
import '../common/common.dart';
import '../tags/route_handler.dart';

class CollectionsPage extends StatefulWidget {
  final CollectionModel collectionModel;

  CollectionsPage(this.collectionModel);

  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  void initState() {
    widget.collectionModel.fetch();
    super.initState();
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) => _buildListTile(context, index),
      itemCount: widget.collectionModel.collections.length,
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

  Widget _buildListTile(BuildContext context, int index) {
    var item = widget.collectionModel.collections[index];

    return Slidable(
      key: Key(item.id.toString()),
      delegate: SlidableBehindDelegate(),
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
          onDismissed: (actionType) {
            if (actionType == SlideActionType.secondary)
              widget.collectionModel.deleteCollection(index);
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
            )
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: item.isFav ? 'Desmarcar favorito' : 'Marcar favorito',
          color: Colors.indigo,
          icon: item.isFav ? Icons.favorite_border : Icons.favorite,
          onTap: () {
            widget.collectionModel.toggleFav(index);
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

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há coleções cadastradas.'),
    );
  }

  Widget _buildDisplay(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, CollectionModel model) {
        Widget content = _buildEmpty();

        if (model.collections.length > 0 && !model.isLoading) {
          content = _buildList();
        } else if (model.collections.length == 0 && !model.isLoading) {
          content = _buildEmpty();
        } else if (model.isLoading) {
          content = ShimmerList();
        }
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetch,
        );
      },
    );
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            title: Text(
              'Tags mais utilizadas',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            onTap: () => Application.router.navigateTo(context, TagsRoute.tags),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Minhas coleções'),
      ),
      // body:  Shimmers.listView(context),
      body: _buildDisplay(context),
      floatingActionButton: CollectionsPageFab(),
    );
  }
}
