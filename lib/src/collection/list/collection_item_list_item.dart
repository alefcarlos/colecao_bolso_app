import 'package:flutter/material.dart';
import '../collection_item_model.dart';
import '../../common/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../collections/collection_model.dart';
import '../../config/application.dart';

class CollectionItemListItem extends StatelessWidget {
  final CollectionItem _item;
  final Collection _collection;

  CollectionItemListItem(this._item, this._collection);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          _CollectionItemCard(_item, _collection),
          _CollectionItemThumb(_item),
        ],
      ),
    );
  }
}

class _CollectionItemCard extends StatelessWidget {
  final CollectionItem item;
  final Collection collection;
  _CollectionItemCard(this.item, this.collection);

  static final headerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  static final regularTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 9.0,
    fontWeight: FontWeight.w400,
  );

  static final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
    var rgb = collection.rgbColor.split(',');
    var color = Color.fromARGB(
      100,
      int.parse(rgb[0]),
      int.parse(rgb[1]),
      int.parse(rgb[2]),
    );

    return Container(
      height: 125.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 4.0),
            Text(
              '#${item.number}',
              style: headerTextStyle,
            ),
            Container(height: 10.0),
            Text('Tenho ${item.quantity}', style: subHeaderTextStyle),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: Theme.of(context).accentColor),
            CollectionItemTag(item.tags)
          ],
        ),
      ),
    );
  }
}

class _CollectionItemThumb extends StatelessWidget {
  final CollectionItem item;
  _CollectionItemThumb(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Application.router
          .navigateTo(context, '/collection/item/${item.id}'),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: Hero(
          tag: 'collection-item-${item.id}',
          child: CachedNetworkImage(
            imageUrl:
                "https://ptanime.com/wp-content/uploads/2016/10/JoJos-Bizarre-adventura-part-3-stardust-crusaders-viz-hardcover-volume1.jpg",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
            height: 92.0,
            width: 92.0,
          ),
        ),
      ),
    );
  }
}
