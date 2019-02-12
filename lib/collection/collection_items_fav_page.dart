import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/common.dart';
import 'bloc/fav/exporter.dart';
import '../bloc/exporter.dart';
import 'collection_service.dart';
import 'collection_item_simples_list.dart';

class CollectionFavItemsPage extends StatefulWidget {
  final int _collectionId;
  final CollectionService _service;

  CollectionFavItemsPage(this._collectionId, this._service);

  _CollectionFavItemsPageState createState() => _CollectionFavItemsPageState();
}

class _CollectionFavItemsPageState extends State<CollectionFavItemsPage> {
  CollectionFavItemsBloc _bloc;

  @override
  void initState() {
    _bloc = CollectionFavItemsBloc(widget._service);
    _bloc.dispatch(CollectionFetchFavItemsEvent(widget._collectionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: _bloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is BlocLoadingIndicatorState) {
          return ShimmerList();
        }

        if (state is BlocErrorState) {
          return Empty(
            text: Text(state.error),
          );
        }

        if (state is CollectionItemsLoadedFavState) {
          if (state.data.isEmpty) {
            return Empty(
              text: Text('Que tal adicionar alguns itens favoritos ?'),
            );
          }
          return CollectionItemSimpleList(state);
        }
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
