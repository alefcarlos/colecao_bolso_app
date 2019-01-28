import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/collection_item.dart';
import '../../helpers/shimmers.dart' as Shimmers;
import '../../models/collection_item.dart';

class CollectionListItemsDefaultView extends StatefulWidget {
  final int collectionId;
  final CollectionItemModel collectionItemModel;
  final Function getData;

  CollectionListItemsDefaultView(this.collectionId, this.collectionItemModel, this.getData);

  _CollectionListItemsViewDefaultState createState() =>
      _CollectionListItemsViewDefaultState();
}

class _CollectionListItemsViewDefaultState
    extends State<CollectionListItemsDefaultView> {
  @override
  void initState() {
    widget.collectionItemModel.fetch(widget.collectionId);
    super.initState();
  }

  Widget _buildList(List<CollectionItem> data) {
    return Container(
      margin: EdgeInsets.only(top: 7.0),
      child: ListView.builder(
        itemBuilder: (context, index) => _buildListTile(data, context, index),
        itemCount: data.length,
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Ainda não há items marcados como favoritos.'),
    );
  }

  Widget _buildListTile(
    List<CollectionItem> data,
    BuildContext context,
    int index,
  ) {
    var item = data[index];

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/food.jpg')),
          title: Text('#${item.number}'),
          subtitle: Text('Tenho ${item.quantity}'),
        ),
        Divider()
      ],
    );
  }

  Widget _buildDisplay(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, CollectionItemModel model) {
        Widget content = _buildEmpty();

        if (model.collectionsItems.length > 0 && !model.isLoading) {
          var data = widget.getData(widget.collectionId);

          //Depois que obteve o sitens da coleção selecionada
          if (data.length > 0) content = _buildList(data);
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
