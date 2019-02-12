import 'package:flutter/material.dart';
import 'collection_item_model.dart';

class CollectionItemSimpleList extends StatelessWidget {
  final List<CollectionItem> _data;

  CollectionItemSimpleList(this._data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var item = _data[index];

          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/food.jpg')),
                title: Text('#${item.number}'),
                subtitle: Text('Tenho ${item.quantity}'),
              ),
              Divider()
            ],
          );
        },
        itemCount: _data.length,
      ),
    );
  }
}
