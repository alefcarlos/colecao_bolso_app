import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'collection_item_model.dart';
import '../common/common.dart';
import 'bloc/list/exporter.dart';
import '../bloc/exporter.dart';

class CollectionFavItemsPage extends StatefulWidget {
  final int _collectionId;
  final CollectionBloc _collectionBloc;

  CollectionFavItemsPage(this._collectionId, this._collectionBloc);

  _CollectionFavItemsPageState createState() => _CollectionFavItemsPageState();
}

class _CollectionFavItemsPageState extends State<CollectionFavItemsPage> {
  @override
  void initState() {
    widget._collectionBloc
        .dispatch(CollectionFetchFavItemsEvent(widget._collectionId));
    super.initState();
  }

  Widget _buildList(CollectionItemsLoadedFavState state) {
    return Container(
      margin: EdgeInsets.only(top: 7.0),
      child: ListView.builder(
        itemBuilder: (context, index) =>
            _buildListTile(state.data, context, index),
        itemCount: state.data.length,
      ),
    );
  }

  Widget _buildListTile(
    List<CollectionItem> data,
    BuildContext context,
    int index,
  ) {
    var item = data[index];

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/food.jpg')),
          title: Text('#${item.number}'),
          subtitle: Text('Tenho ${item.quantity}'),
        ),
        Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: widget._collectionBloc,
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
          return _buildList(state);
        }
      },
    );
  }
}
