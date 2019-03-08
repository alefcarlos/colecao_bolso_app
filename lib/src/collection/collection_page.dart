import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'list/collection_items_page.dart';
import 'list/collection_items_fav_page.dart';
import 'bloc/list/exporter.dart';
import 'bloc/fav/exporter.dart';
import 'bloc/repeated/exporter.dart';
import 'list/collection_items_repeated_page.dart';
import 'collection_service.dart';
import '../config/application.dart';
import '../collections/collection_model.dart';

class CollectionPage extends StatefulWidget {
  final int collectionId;
  final Collection collection;

  CollectionPage(this.collectionId, this.collection);

  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  CollectionBloc collectionBloc;
  CollectionFavItemsBloc collectionFavItemsBloc;
  CollectionRepeatedItemsBloc collectionRepeatedItemsBloc;
  GlobalKey bottomNavigationKey = GlobalKey();
  PageController _pageController = PageController();

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
    final FancyBottomNavigationState fState = bottomNavigationKey.currentState;
    fState.setPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collection.name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Adicionar item',
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
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          CollectionListItemsView(
              widget.collectionId, collectionBloc, widget.collection),
          CollectionRepeatedItemsPage(
              widget.collectionId, collectionRepeatedItemsBloc),
          CollectionFavItemsPage(widget.collectionId, collectionFavItemsBloc),
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        key: bottomNavigationKey,
        onTabChangedListener: navigationTapped,
        tabs: [
          TabData(
            iconData: Icons.view_list,
            title: 'Itens',
          ),
          TabData(
            iconData: Icons.playlist_add_check,
            title: 'Repetidos',
          ),
          TabData(
            iconData: Icons.favorite,
            title: 'Favoritos',
          )
        ],
      ),
    );
  }
}
