import 'package:flutter/material.dart';
import './word_cloud.dart';
import '../../scoped_models/item_tag.dart';

class TagsPage extends StatelessWidget {
  final ItemTagModel model;

  TagsPage(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: WordCloud(model),
      appBar: AppBar(
        title: Text('Tags mais utilizadas'),
      ),
    );
  }
}
