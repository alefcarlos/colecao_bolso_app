import 'package:flutter/material.dart';
import 'list/collection_items_page.dart';
import 'list/collection_items_fav_page.dart';
import '../config/app_config.dart';
import 'bloc/list/exporter.dart';
import 'bloc/fav/exporter.dart';
import 'bloc/repeated/exporter.dart';
import 'list/collection_items_repeated_page.dart';
import 'collection_service.dart';

class CollectionPage extends StatefulWidget {
  final int collectionId;
  final String collectionName;

  CollectionPage(this.collectionId, this.collectionName);

  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  CollectionBloc collectionBloc;
  CollectionFavItemsBloc collectionFavItemsBloc;
  CollectionRepeatedItemsBloc collectionRepeatedItemsBloc;

  PageController _pageController = PageController();
  var _page = 0;

  @override
  void initState() {
    var collectionService = CollectionService.of(context);
    collectionBloc = CollectionBloc(collectionService);
    collectionFavItemsBloc = CollectionFavItemsBloc(collectionService);
    collectionRepeatedItemsBloc =
        CollectionRepeatedItemsBloc(collectionService);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    collectionBloc.dispose();
    collectionFavItemsBloc.dispose();
    collectionRepeatedItemsBloc.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collectionName),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          CollectionListItemsView(widget.collectionId, collectionBloc),
          CollectionRepeatedItemsPage(
              widget.collectionId, collectionRepeatedItemsBloc),
          CollectionFavItemsPage(widget.collectionId, collectionFavItemsBloc),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigationTapped,
        currentIndex: _page,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('Itens'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            title: Text('Repetidos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoritos'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Application.router
              .navigateTo(
                  context, '/collection/${widget.collectionId}/item/create')
              .then(
            (result) {
              if (result != null) {
                collectionBloc.dispatch(
                    CollectionFetchItemsEvent(widget.collectionId, false));
              }
            },
          );
        },
        tooltip: 'Adicionar item',
        child: Icon(Icons.camera_enhance),
      ),
    );
  }
}
