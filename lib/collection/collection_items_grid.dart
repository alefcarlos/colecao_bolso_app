import 'package:flutter/material.dart';
import 'bloc/list/exporter.dart';
import 'collection_item_grid_item.dart';
import '../common/common.dart';

class CollectionItemGrid extends StatelessWidget {
  final CollectionBloc _bloc;
  final int _collectionId;
  final CollectionItemsLoadedState _state;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  CollectionItemGrid(this._bloc, this._state, this._collectionId) {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.dispatch(CollectionFetchItemsEvent(_collectionId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) {
          if (index >= _state.data.length) {
            return BottomLoader();
          }

          return CollectionItemGridItem(_state.data[index], _bloc);
        },
        itemCount:
            _state.hasReachedMax ? _state.data.length : _state.data.length + 1,
        controller: _scrollController,
      ),
    );
  }
}
