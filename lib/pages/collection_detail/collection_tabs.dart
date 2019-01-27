import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './collection_favorite.dart';
import './collection_list.dart';
import './collection_repetead.dart';
import '../../scoped_models/collection.dart';

class CollectionPage extends StatelessWidget {
  final int index;

  CollectionPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: ScopedModelDescendant<CollectionModel>(builder:
                (BuildContext context, Widget child, CollectionModel model) {
              return Text(model.collections[index].name);
            }),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.view_list,
                      color: Theme.of(context).primaryIconTheme.color),
                  text: 'Itens',
                ),
                Tab(
                  icon: Icon(Icons.playlist_add_check,
                      color: Theme.of(context).primaryIconTheme.color),
                  text: 'Repetidos',
                ),
                Tab(
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  text: 'Favoritos',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              CollectionListItemsView(),
              CollectionRepeatedItemsView(),
              CollectionFavoriteItemsView(),
            ],
          ),
        ),
      ),
    );
  }
}
