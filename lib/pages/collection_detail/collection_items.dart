import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/collection_item.dart';
import '../../models/collection_item.dart';

class CollectionListItemsView extends StatelessWidget {
  final int collectionId;

  CollectionListItemsView(this.collectionId);

  Widget _buildList(List<CollectionItem> items) {
    return Container(
      margin: EdgeInsets.only(top: 7.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => _buildListTile(items, context, index),
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
    List<CollectionItem> items
    BuildContext context,
    int index,
  ) {
    var item = items[index];

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScopedModelDescendant<CollectionItemModel>(builder: (BuildContext context, Widget child, CollectionItemModel model) {
            return ListTile(
              title: Text('#${item.number}'),
              subtitle: Text('Tenho ${item.quantity}'),
              trailing: IconButton(
                onPressed: () => model.toggleFav(collectionId, index),
                icon: Icon(
                  item.isFav ? Icons.favorite : Icons.favorite_border,
                  color: item.isFav ? Colors.red : null,
                ),
              ),
            );
          },),
        ],
      ),
    );
  }

  Widget _buildDisplay(BuildContext context) {
    var data = CollectionItemModel.of(context).collectionsItems;

      return (data.length > 0) ? _buildList(data) : _buildEmpty();
  }

  @override
  Widget build(BuildContext context) => _buildDisplay(context);
}
