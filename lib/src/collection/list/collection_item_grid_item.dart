import 'package:flutter/material.dart';
import '../collection_item_model.dart';
import '../../common/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../collections/collection_model.dart';

class CollectionItemGridItem extends StatelessWidget {
  final CollectionItem _item;
  final Collection _collection;

  CollectionItemGridItem(this._item, this._collection);

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
    var rgb = _collection.rgbColor.split(',');
    var color = Color.fromARGB(
                  100,
                  int.parse(rgb[0]),
                  int.parse(rgb[1]),
                  int.parse(rgb[2]),
                );
    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            height: 125.0,
            margin: new EdgeInsets.only(left: 46.0),
            decoration: new BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: new Container(
              margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
              constraints: new BoxConstraints.expand(),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(height: 4.0),
                  new Text(
                    '#${_item.number}',
                    style: headerTextStyle,
                  ),
                  new Container(height: 10.0),
                  new Text('Tenho ${_item.quantity}',
                      style: subHeaderTextStyle),
                  new Container(
                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                      height: 2.0,
                      width: 18.0,
                      color: Theme.of(context).accentColor),
                  CollectionItemTag(_item.tags)
                ],
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 16.0),
            child: CachedNetworkImage(
              imageUrl:
                  "https://ptanime.com/wp-content/uploads/2016/10/JoJos-Bizarre-adventura-part-3-stardust-crusaders-viz-hardcover-volume1.jpg",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  new Icon(Icons.error_outline),
              height: 92.0,
              width: 92.0,
            ),
          ),
        ],
      ),
    );
  }
}
