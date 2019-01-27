import 'package:flutter/material.dart';
import './collection_favorite_items.dart';
import './collection_items.dart';
import './collection_repetead_items.dart';
import '../../scoped_models/collection.dart';
import '../../scoped_models/collection_item.dart';

class CollectionPage extends StatelessWidget {
  final int index;

  CollectionPage(this.index);

  @override
  Widget build(BuildContext context) {
    var collectionModel = CollectionModel.of(context);
    var collectionItemModel = CollectionItemModel.of(context);

    var collection = collectionModel.collections[index];

    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(collection.name),
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
              CollectionListItemsView(collection.id),
              CollectionRepeatedItemsView(collectionItemModel.getRepeatedItems(collection.id)),
              CollectionFavoriteItemsView(collectionItemModel.getFavItems(collection.id)),
            ],
          ),
        ),
      ),
    );
  }
}
