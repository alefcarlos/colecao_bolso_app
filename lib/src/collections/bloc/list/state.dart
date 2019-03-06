import 'package:meta/meta.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';

import '../../collection_model.dart';

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
