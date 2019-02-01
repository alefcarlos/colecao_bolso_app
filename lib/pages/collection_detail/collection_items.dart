import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/collection_item.dart';
import '../../models/collection_item.dart';
import '../../helpers/shimmers.dart' as Shimmers;
import '../../widgets/ui-elements/tag.dart';

class CollectionListItemsView extends StatefulWidget {
    final int collectionId;
  final CollectionItemModel collectionItemModel;

  CollectionListItemsView(this.collectionId, this.collectionItemModel);

  _CollectionListItemsViewState createState() =>      _CollectionListItemsViewState();
}

class _CollectionListItemsViewState extends State<CollectionListItemsView>{
  @override
  void initState() {
    widget.collectionItemModel.fetch(widget.collectionId);
    super.initState();
  }

  Widget _buildList(List<CollectionItem> items) {
    return Container(
      margin: EdgeInsets.only(top: 7.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
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

    return ScopedModelDescendant(
    builder: (BuildContext context, Widget child, CollectionItemModel model) {
          return Card(
      child: Column(
        children: [
          Image.asset('assets/food.jpg',),
          ListTile(
              title: Text('#${item.number}'),
              subtitle: Text('Tenho ${item.quantity}'),
              trailing: IconButton(
                onPressed: () => model.toggleFav(widget.collectionId, index, item.id),
                icon: Icon(
                  item.isFav ? Icons.favorite : Icons.favorite_border,
                  color: item.isFav ? Colors.red : null,
                ),
              ),
            ),
          CollectionItemTag(item.tags)
        ],
        ),
    );
    });

  }


  Widget _buildDisplay(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, CollectionItemModel model) {
        Widget content = _buildEmpty();

        if (model.collectionsItems.length > 0 && !model.isLoading) {
          var data = model.getItems(widget.collectionId);

          //Depois que obteve os itens da coleção selecionada
          if (data.length > 0) content = _buildList(data);
        } else if(model.collectionsItems.length ==0 && !model.isLoading){
          content = _buildEmpty();
        } else if (model.isLoading) {
          content = Shimmers.listView(context);
        }
        return RefreshIndicator(
          child: content,
          onRefresh: () => model.fetch(widget.collectionId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildDisplay(context);
}
