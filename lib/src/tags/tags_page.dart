import 'package:flutter/material.dart';
import './tags_cloud.dart';

class TagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TagsCloud(),
      appBar: AppBar(
        title: Text('Tags mais utilizadas'),
      ),
    );
  }
}
