import 'package:flutter/material.dart';

class CollectionItemTag extends StatelessWidget {
  final List<String> _tags;
  final int count;

  CollectionItemTag(this._tags, {this.count = 3});

  List<Widget> _builTagItem(BuildContext context) {
    if (_tags == null) {
      return [
        Center(
          child: Text(
            'Sem marcadores',
            style: TextStyle(fontSize: 17.0),
          ),
        )
      ];
    }

    return _tags.take(count).map((tag) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.5),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.green,
          borderRadius: BorderRadius.circular(65.0),
        ),
        child: Text(
          '$tag',
          style: TextStyle(color: Colors.white,fontSize: 15.0),
          
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _builTagItem(context),
    );
  }
}
