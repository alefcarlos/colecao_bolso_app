import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../collection_model.dart';

abstract class CollectionsState extends Equatable {
  CollectionsState([List props = const []]) : super(props);
}

class CollectionsLoadingState extends CollectionsState{}

class CollectionsErrorState extends CollectionsState {
  final String error;
  CollectionsErrorState(this.error)
      : assert(error != null && error.isNotEmpty),
        super([error]);

  @override
  String toString() => "CollectionsErrorState";
}


class CollectionsLoadedState extends CollectionsState {
  final List<Collection> data;
  final bool hasReachedMax;

  CollectionsLoadedState({
    @required this.data,
    @required this.hasReachedMax,
  })  : assert(data != null),
        assert(hasReachedMax != null),
        super([data, hasReachedMax]);

  CollectionsLoadedState copyWith({
    List<Collection> data,
    bool hasReachedMax,
  }) {
    return CollectionsLoadedState(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => "CollectionsLoadedState, data.lenght(${data.length}, hasReachedMax($hasReachedMax))";
}
