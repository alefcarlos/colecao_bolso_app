import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final Text text;

  Empty({this.text});

  @override
  Widget build(BuildContext context) {
    var display =
        text == null ? Text('Ainda não há coleções cadastradas.') : text;
    return Center(
      child: display,
    );
  }
}
