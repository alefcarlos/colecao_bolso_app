import 'package:flutter/material.dart';
import 'collection_item_scoped_model.dart';
import 'collection_items_listview.dart';
import 'collection_items_default_listview.dart';
import '../config/app_config.dart';

class CollectionPage extends StatelessWidget {
  final int index;

  CollectionPage(this.index);

  @override
  Widget build(BuildContext context) {
    // var collectionModel = CollectionModel.of(context);
    var collectionItemModel = CollectionItemModel.of(context);
    // var collection = collectionModel.collections[index];

    return Container();
    //   child: DefaultTabController(
    //     length: 3,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: Text(collection.name),
    //         bottom: TabBar(
    //           tabs: <Widget>[
    //             Tab(
    //               icon: Icon(Icons.view_list,
    //                   color: Theme.of(context).primaryIconTheme.color),
    //               text: 'Itens',
    //             ),
    //             Tab(
    //               icon: Icon(Icons.playlist_add_check,
    //                   color: Theme.of(context).primaryIconTheme.color),
    //               text: 'Repetidos',
    //             ),
    //             Tab(
    //               icon: Icon(Icons.favorite_border, color: Colors.red),
    //               text: 'Favoritos',
    //             )
    //           ],
    //         ),
    //       ),
    //       body: TabBarView(
    //         children: <Widget>[
    //           CollectionListItemsView(collection.id, collectionItemModel),
    //           CollectionListItemsDefaultView(collection.id, collectionItemModel,
    //               collectionItemModel.getRepeatedItems),
    //           CollectionListItemsDefaultView(collection.id, collectionItemModel,
    //               collectionItemModel.getFavItems),
    //         ],
    //       ),
    //       floatingActionButton: FloatingActionButton(
    //         onPressed: () {
    //           Application.router.navigateTo(context, '/collection/${collection.id}/item/create');
    //         },
    //         tooltip: 'Adicionar item',
    //         child: Icon(Icons.camera_enhance),
    //       ),
    //     ),
    //   ),
    // );
  }
}
