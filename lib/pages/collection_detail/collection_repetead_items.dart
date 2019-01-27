import 'package:flutter/material.dart';
import '../../models/collection_item.dart';

class CollectionRepeatedItemsView extends StatelessWidget {
  final List<CollectionItem> items;

  CollectionRepeatedItemsView(this.items);

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.only(top: 7.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => _buildListTile(context, index),
        itemCount: items.length,
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há items cadastros.'),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    int index,
  ) {
    var item = items[index];

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('#${item.number}'),
            subtitle: Text('Tenho ${item.quantity}'),
            trailing: Icon(
              item.isFav ? Icons.favorite : Icons.favorite_border,
              color: item.isFav ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplay(BuildContext context) {
    return (items.length > 0) ? _buildList() : _buildEmpty();
  }

  @override
  Widget build(BuildContext context) => _buildDisplay(context);
}
