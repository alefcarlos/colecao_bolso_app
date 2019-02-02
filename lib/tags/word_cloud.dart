import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../common/common.dart';
import './tag_scoped_model.dart';
import './tag_model.dart';

class WordCloud extends StatefulWidget {
  final ItemTagModel model;

  WordCloud(this.model);

  _WordCloudState createState() => _WordCloudState();
}

class _WordCloudState extends State<WordCloud> {
  final Random _random = Random();
  List<Color> tagColors = [
    Colors.red,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.pink,
    Colors.cyan,
    Colors.cyanAccent
  ];

  @override
  void initState() {
    widget.model.fetch();
    super.initState();
  }

  Widget _buildEmpty() =>
      Center(child: Text('Você ainda não tem itens cadastrados'));

  Widget _buildTags(context, List<ItemTag> tags) {
    List<Widget> widgets = tags
        .map((tag) => ScatterItem(FlutterHashtag('#${tag.tag}',
            tagColors[_random.nextInt(tagColors.length)], tag.count + 10, _random.nextBool())))
        .toList();

    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return Center(
      child: FittedBox(
        child: Scatter(
          fillGaps: true,
          delegate: ArchimedeanSpiralScatterDelegate(ratio: ratio),
          children: widgets,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (
      BuildContext context,
      Widget child,
      ItemTagModel model,
    ) {
      Widget content = _buildEmpty();

      if (model.tags == null) return content;

      if (model.tags.length > 0 && !model.isLoading) {
        content = _buildTags(context, model.tags);
      } else if (model.tags.length == 0 && !model.isLoading) {
        content = _buildEmpty();
      } else if (model.isLoading) {
        content = ShimmerList();
      }

      return RefreshIndicator(
        child: content,
        onRefresh: model.fetch,
      );
    });
  }
}

class ScatterItem extends StatelessWidget {
  ScatterItem(this.hashtag);
  final FlutterHashtag hashtag;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.body1.copyWith(
          fontSize: hashtag.size.toDouble(),
          color: hashtag.color,
        );
    return RotatedBox(
      quarterTurns: hashtag.rotated ? 1 : 0,
      child: Text(
        hashtag.hashtag,
        style: style,
      ),
    );
  }
}

class FlutterHashtag {
  const FlutterHashtag(
    this.hashtag,
    this.color,
    this.size,
    this.rotated,
  );
  final String hashtag;
  final Color color;
  final int size;
  final bool rotated;
}
