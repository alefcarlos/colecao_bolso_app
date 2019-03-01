import 'package:flutter/material.dart';
import 'list/collection_items_page.dart';
import 'list/collection_items_fav_page.dart';
import '../config/app_config.dart';
import 'bloc/list/exporter.dart';
import 'bloc/fav/exporter.dart';
import 'bloc/repeated/exporter.dart';
import 'list/collection_items_repeated_page.dart';

class CollectionPage extends StatelessWidget {
  final int collectionId;

  CollectionPage(this.collectionId);

  @override
  Widget build(BuildContext context) {
    var bloc = CollectionBloc.of(context);
    var repeatedBloc = CollectionRepeatedItemsBloc.of(context);
    var favBloc = CollectionFavItemsBloc.of(context);

    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detalhes da coleção'),
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
              CollectionListItemsView(collectionId, bloc),
              CollectionRepeatedItemsPage(collectionId, repeatedBloc),
              CollectionFavItemsPage(collectionId, favBloc),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Application.router
                  .navigateTo(context, '/collection/$collectionId/item/create');
            },
            tooltip: 'Adicionar item',
            child: Icon(Icons.camera_enhance),
          ),
        ),
      ),
    );
  }
}
