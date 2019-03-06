import 'package:flutter/material.dart';
import 'empty.dart';

class EmptyForRefreshIndicator extends StatelessWidget {
  final Text text;

  EmptyForRefreshIndicator({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Empty(
          text: text,
        ),
      ],
    );
  }
}
