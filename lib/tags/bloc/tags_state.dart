import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../tag_model.dart';

abstract class TagsState extends Equatable {
  TagsState([List props = const []]) : super(props);
}

class TagsErrorState extends TagsState {
  final String error;
  TagsErrorState(this.error)
      : assert(error != null && error.isNotEmpty),
        super([error]);
}

class TagsLoadingState extends TagsState {}

class TagsLoadedState extends TagsState {
  final List<ItemTag> tags;

  TagsLoadedState({@required this.tags})
      : assert(tags != null),
        super([tags]);

  // TagsLoadedState copyWith({
  //   List<ItemTag> tags,
  // }) {
  //   return TagsLoadedState(tags: tags ?? this.tags);
  // }
}
