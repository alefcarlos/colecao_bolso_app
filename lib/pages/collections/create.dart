import 'package:flutter/material.dart';
import '../../config/application.dart';

class CreateCollectionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nova Coleção'),
        ),
        body: Center(
          child: Text('nova Coleçaõ'),
        ),
      ),
    );
  }
}