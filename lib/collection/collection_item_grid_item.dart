import 'package:flutter/material.dart';
import 'collection_item_model.dart';
import '../common/common.dart';
import 'bloc/list/exporter.dart';

class CollectionItemGridItem extends StatelessWidget {
  final CollectionItem _item;
  final CollectionBloc _bloc;

  CollectionItemGridItem(this._item, this._bloc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            'assets/food.jpg',
          ),
          ListTile(
            title: Text('#${_item.number}'),
            subtitle: Text('Tenho ${_item.quantity}'),
            trailing: IconButton(
              onPressed: () => {},
              //TODO: toogle fav
              // model.toggleFav(widget.collectionId, index, item.id),
              icon: Icon(
                _item.isFav ? Icons.favorite : Icons.favorite_border,
                color: _item.isFav ? Colors.red : null,
              ),
            ),
          ),
          CollectionItemTag(_item.tags)
        ],
      ),
    );
  }
}
