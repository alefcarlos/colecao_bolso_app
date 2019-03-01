import 'package:flutter/material.dart';
import './tags_cloud.dart';
import 'bloc/bloc.dart';

class TagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TagsCloud(TagsBloc.of(context)),
      appBar: AppBar(
        title: Text('Tags mais utilizadas'),
      ),
    );
  }
}
