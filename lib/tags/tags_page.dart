import 'package:flutter/material.dart';
import './tags_cloud.dart';
import 'bloc/bloc.dart';

class TagsPage extends StatelessWidget {
  final TagsBloc _tagsBloc;

  TagsPage(this._tagsBloc);

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
