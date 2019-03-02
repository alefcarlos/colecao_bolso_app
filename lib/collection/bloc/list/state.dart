import 'package:meta/meta.dart';

import '../../../bloc/exporter.dart';
import '../../collection_item_model.dart';

class CollectionUnintializedState extends BlocBaseState {
  @override
  String toString() => "CollectionUnintializedState";
}

class CollectionItemsLoadedState extends BlocBaseState {
  final List<CollectionItem> data;
  final bool hasReachedMax;

  CollectionItemsLoadedState({
    @required this.data,
    @required this.hasReachedMax,
  })  : assert(data != null),
        assert(hasReachedMax != null),
        super([data, hasReachedMax]);

  CollectionItemsLoadedState copyWith({
    List<CollectionItem> data,
    bool hasReachedMax,
  }) {
    return CollectionItemsLoadedState(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      "CollectionItemsLoadedState, data.lenght(${data.length}, hasReachedMax($hasReachedMax))";
}
