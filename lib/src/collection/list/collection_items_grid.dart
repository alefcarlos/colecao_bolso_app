import 'package:flutter/material.dart';
import 'package:colecao_bolso_app/application/shared/shared.dart';

import '../bloc/list/exporter.dart';
import 'collection_item_grid_item.dart';
import '../../collections/collection_model.dart';

class CollectionItemGrid extends StatelessWidget {
  final CollectionBloc _bloc;
  final CollectionItemsLoadedState _state;
  final Collection _collection;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  CollectionItemGrid(
      this._bloc, this._state, this._collection) {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.dispatch(CollectionFetchItemsEvent(_collection.id, true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context, index) {
            if (index >= _state.data.length) {
              return BottomLoader();
            }

            return CollectionItemGridItem(_state.data[index], _collection);
          },
          itemCount: _state.hasReachedMax
              ? _state.data.length
              : _state.data.length + 1,
          controller: _scrollController,
          padding: new EdgeInsets.symmetric(vertical: 16.0)),
    );
  }
}
