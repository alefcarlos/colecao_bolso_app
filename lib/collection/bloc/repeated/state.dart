import '../../../bloc/exporter.dart';
import '../../collection_item_model.dart';

class CollectionItemsLoadedRepeatedState extends BlocBaseState {
  final List<CollectionItem> data;
  CollectionItemsLoadedRepeatedState(this.data) : super([data]);

  @override
  String toString() =>
      "CollectionItemsLoadedRepeatedState, data.length(${data.length})";
}
