import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'collection_item_model.dart';

class CollectionDetailPage extends StatelessWidget {
  final CollectionItem collection;
  CollectionDetailPage(this.collection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[
            Container(
              child: Hero(
                tag: 'collection-item-${collection.id}',
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    imageUrl:
                        "https://ptanime.com/wp-content/uploads/2016/10/JoJos-Bizarre-adventura-part-3-stardust-crusaders-viz-hardcover-volume1.jpg",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline)),
              ),
              constraints: BoxConstraints.expand(height: 300.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 190.0),
              height: 110.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0x00736AB7), Color(0xFF736AB7)],
                  stops: [0.0, 0.9],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: BackButton(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
