import 'dart:async';

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
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    widget._collectionsBloc.dispatch(CollectionsFetchEvent());
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      widget._collectionsBloc.dispatch(CollectionsFetchEvent(fromScroll: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: widget._collectionsBloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is BlocLoadingIndicatorState) {
          return ShimmerList();
        }

        if (state is BlocErrorState) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();

          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Empty(
                  text: Text(state.error),
                ),
              ],
            ),
          );
        }

        if (state is CollectionsLoadedState) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();

          if (state.data.isEmpty) {
            return Empty(
              text: Text('Você ainda não cadastrou nenhuma coleção.'),
            );
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index >= state.data.length) {
                  return BottomLoader();
                }

                return CollectionsListTile(
                    state.data[index], widget._collectionsBloc);
              },
              itemCount: state.hasReachedMax
                  ? state.data.length
                  : state.data.length + 1,
              controller: _scrollController,
            ),
          );
        }
      },
    );
  }

  Future<void> _refreshData() {
    widget._collectionsBloc.dispatch(CollectionsFetchEvent());
    return _refreshCompleter.future;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
