import 'package:flutter/material.dart';
import 'bloc/fav/exporter.dart';

class CollectionItemSimpleList extends StatelessWidget {
  final CollectionItemsLoadedFavState _state;

  CollectionItemSimpleList(this._state);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var item = _state.data[index];

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
        itemCount: _state.data.length,
      ),
    );
  }
}
