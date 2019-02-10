import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import './tag_model.dart';
import 'bloc/exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/common.dart';

class TagsCloud extends StatefulWidget {
  final TagsBloc _bloc;

  TagsCloud(this._bloc) : assert(_bloc != null);

  @override
  State<StatefulWidget> createState() => _TagsCloud();
}

class _TagsCloud extends State<TagsCloud> {
  final Random _random = Random();
  final List<Color> _tagColors = const [
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
    widget._bloc.dispatch(TagsEvent.fetch);
    super.initState();
  }

  Widget _buildTags(context, List<ItemTag> tags) {
    List<Widget> widgets = tags
        .map((tag) => ScatterItem(FlutterHashtag(
            '#${tag.tag}',
            _tagColors[_random.nextInt(_tagColors.length)],
            tag.count + 10,
            _random.nextBool())))
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
    return BlocBuilder<TagsEvent, TagsState>(
      bloc: widget._bloc,
      builder: (BuildContext context, TagsState state) {
        if (state is TagsLoadingState) {
          return LoadingIndicator();
        }

        if (state is TagsLoadedState) {
          var tags = state.tags;
          return tags.length > 0 ? _buildTags(context, tags) : Empty(text: Text('Você ainda não tem itens cadastrados'));
        }

        if (state is TagsErrorState) {
          return Empty(
            text: Text(state.error),
          );
        }
      },
    );
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
