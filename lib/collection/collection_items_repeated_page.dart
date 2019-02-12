import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/common.dart';
import 'bloc/repeated/exporter.dart';
import '../bloc/exporter.dart';
import 'collection_service.dart';
import 'collection_item_simple_list.dart';

class CollectionRepeatedItemsPage extends StatefulWidget {
  final int _collectionId;
  final CollectionService _service;

  CollectionRepeatedItemsPage(this._collectionId, this._service);

  _CollectionRepeatedItemsPageState createState() => _CollectionRepeatedItemsPageState();
}

class _CollectionRepeatedItemsPageState extends State<CollectionRepeatedItemsPage> {
  CollectionRepeatedItemsBloc _bloc;

  @override
  void initState() {
    _bloc = CollectionRepeatedItemsBloc(widget._service);
    _bloc.dispatch(CollectionFetchRepeatedItemsEvent(widget._collectionId));
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

        if (state is CollectionItemsLoadedRepeatedState) {
          if (state.data.isEmpty) {
            return Empty(
              text: Text('Isso é boa notícia, não ?'),
            );
          }
          return CollectionItemSimpleList(state.data);
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
