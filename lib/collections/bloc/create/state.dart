import 'package:meta/meta.dart';

import '../../../bloc/state_base.dart';
import '../../collection_model.dart';

class LoadingCollectionsState extends BlocBaseState {

  @override
  String toString() {
    return "LoadingCollectionsState";
  }
}

class CollectionsLoadedState extends BlocBaseState {
  final List<Collection> data;

  CollectionsLoadedState({
    @required this.data,
  })  : assert(data != null),
        super([data]);

  @override
  String toString() =>
      "CollectionsLoadedState, data.lenght(${data.length})";
}