import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../tag_model.dart';

abstract class TagsState extends Equatable {
  TagsState([List props = const []]) : super(props);
}

class TagsIsInitiatingState extends TagsState {}

class TagsIsLoadingState extends TagsState {}

class TagsIsReadyState extends TagsState {
  final List<ItemTag> tags;

  TagsIsReadyState({@required this.tags})
      : assert(tags != null),
        super([tags]);
}
