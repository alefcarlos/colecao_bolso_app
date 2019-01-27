import 'package:flutter/material.dart';
import '../../scoped_models/collection_item.dart';
import '../../models/collection_item.dart';

class CollectionListItemsView extends StatelessWidget {
  Widget _buildList(List<CollectionItem> items) {
    return ListView.builder(
      itemBuilder: (context, index) => _buildListTile(items, context, index),
      itemCount: items.length,
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há items cadastros.'),
    );
  }

  Widget _buildListTile(
    List<CollectionItem> items,
    BuildContext context,
    int index,
  ) {
    var item = items[index];

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.number),
        ),
        Divider()
      ],
    );
  }

  Widget _buildDisplay(BuildContext context) {
    var model = CollectionItemModel.of(context);

    var items = model.collectionsItems;
    return (items.length > 0) ? _buildList(items) : _buildEmpty();
  }

  @override
  Widget build(BuildContext context) => _buildDisplay(context);
}
