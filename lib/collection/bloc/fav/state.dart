import '../../../bloc/exporter.dart';
import '../../collection_item_model.dart';

class CollectionItemsLoadedFavState extends BlocBaseState {
  final List<CollectionItem> data;
  CollectionItemsLoadedFavState(this.data) : super([data]);

  @override
  String toString() =>
      "CollectionItemsLoadedFavState, data.length(${data.length})";
}
