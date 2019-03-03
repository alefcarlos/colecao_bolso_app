import 'package:flutter/material.dart';
import '../collection_item_model.dart';
import '../../common/common.dart';
import '../bloc/list/exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CollectionItemGridItem extends StatelessWidget {
  final CollectionItem _item;
  final CollectionBloc _bloc;

  CollectionItemGridItem(this._item, this._bloc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          new CachedNetworkImage(
            imageUrl: "http://via.placeholder.com/350x150",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          ListTile(
            title: Text('#${_item.number}'),
            subtitle: Text('Tenho ${_item.quantity}'),
            trailing: IconButton(
              onPressed: () {
                _bloc.dispatch(CollectionToggleFavEvent(_item.id));
              },
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
