import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/common.dart';
import '../bloc/repeated/exporter.dart';
import '../../bloc/exporter.dart';
import 'collection_item_simple_list.dart';

class CollectionRepeatedItemsPage extends StatefulWidget {
  final int _collectionId;
  final CollectionRepeatedItemsBloc _bloc;

  const CollectionRepeatedItemsPage(this._collectionId, this._bloc);

  _CollectionRepeatedItemsPageState createState() =>
      _CollectionRepeatedItemsPageState();
}

class _CollectionRepeatedItemsPageState
    extends State<CollectionRepeatedItemsPage> {

  CollectionRepeatedItemsBloc get bloc => widget._bloc;

  @override
  void initState() {
    bloc.dispatch(CollectionFetchRepeatedItemsEvent(widget._collectionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: bloc,
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
}
