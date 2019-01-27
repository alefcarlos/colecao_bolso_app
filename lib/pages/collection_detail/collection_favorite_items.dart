import 'package:flutter/material.dart';
import '../../models/collection_item.dart';

class CollectionFavoriteItemsView extends StatelessWidget {
  final List<CollectionItem> items;

  CollectionFavoriteItemsView(this.items);

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.only(top: 7.0),
      child: ListView.builder(
        itemBuilder: (context, index) => _buildListTile(context, index),
        itemCount: items.length,
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há items marcados como favoritos.'),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    int index,
  ) {
    var item = items[index];

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/food.jpg')),
          title: Text('#${item.number}'),
          subtitle: Text('Tenho ${item.quantity}'),
          trailing: Icon(
            item.isFav ? Icons.favorite : Icons.favorite_border,
            color: item.isFav ? Colors.red : null,
          ),
        ),
        Divider()
      ],
    );
  }

  Widget _buildDisplay(BuildContext context) {
    return (items.length > 0) ? _buildList() : _buildEmpty();
  }

  @override
  Widget build(BuildContext context) => _buildDisplay(context);
}
