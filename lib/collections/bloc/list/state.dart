import 'package:meta/meta.dart';
import '../../collection_model.dart';
import '../../../bloc/state_base.dart';

class CollectionsLoadingState extends BlocBaseState {}

class CollectionsErrorState extends BlocBaseState {
  final String error;
  CollectionsErrorState(this.error)
      : assert(error != null && error.isNotEmpty),
        super([error]);

  @override
  String toString() => "CollectionsErrorState";
}

class CollectionsLoadedState extends BlocBaseState {
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
  String toString() =>
      "CollectionsLoadedState, data.lenght(${data.length}, hasReachedMax($hasReachedMax))";
}
