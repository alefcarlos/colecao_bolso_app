import 'package:flutter/material.dart';
import './tags_cloud.dart';
import './tag_scoped_model.dart';
import 'bloc/bloc.dart';

class TagsPage extends StatelessWidget {
  final ItemTagModel model;
  final TagsBloc _tagsBloc;

  TagsPage(this.model, this._tagsBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TagsCloud(_tagsBloc),
      appBar: AppBar(
        title: Text('Tags mais utilizadas'),
      ),
    );
  }
}
