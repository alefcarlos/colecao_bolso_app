import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/common.dart';
import 'bloc/list/exporter.dart';
import 'collections_list_tile.dart';
import '../bloc/exporter.dart';

class CollectionsList extends StatefulWidget {
  final CollectionsBloc _collectionsBloc;

  CollectionsList(this._collectionsBloc) : assert(_collectionsBloc != null);

  _CollectionsListState createState() => _CollectionsListState();
}

class _CollectionsListState extends State<CollectionsList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    widget._collectionsBloc.dispatch(CollectionsFetchEvent());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      print('CollectionsFetchEvent from _onScroll');
      widget._collectionsBloc.dispatch(CollectionsFetchEvent());
    }
  }

  Widget _buildList(CollectionsLoadedState state) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index >= state.data.length) {
          return BottomLoader();
        }

        return CollectionsListTile(state.data[index], widget._collectionsBloc);
      },
      itemCount:
          state.hasReachedMax ? state.data.length : state.data.length + 1,
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: widget._collectionsBloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is CollectionsLoadingState) {
          return ShimmerList();
        }

        if (state is BlocErrorState) {
          return Empty(
            text: Text(state.error),
          );
        }

        if (state is CollectionsLoadedState) {
          if (state.data.isEmpty) {
            return Empty(
              text: Text('Você ainda não cadastrou nenhuma coleção.'),
            );
          }
          return _buildList(state);
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
