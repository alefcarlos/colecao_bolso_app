import '../../../bloc/exporter.dart';

class CollectionFetchRepeatedItemsEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionFetchRepeatedItemsEvent(this.collectionId) : super([collectionId]);
}
