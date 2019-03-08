import 'package:flutter/material.dart';

class CollectionItemTag extends StatelessWidget {
  final List<String> _tags;
  final int count;

  CollectionItemTag(this._tags, {this.count = 3});

  List<Widget> _builTagItem(BuildContext context) {
    if (_tags == null) {
      return [Container()];
    }

    return _tags.take(count).map((tag) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.5),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.green[400],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          '$tag',
          style: TextStyle(color: Colors.white),
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
