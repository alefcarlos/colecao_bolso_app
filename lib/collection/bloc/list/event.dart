import '../../../bloc/exporter.dart';

class CollectionFetchItemsEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionFetchItemsEvent(this.collectionId) : super([collectionId]);
}

class CollectionFetchRepeatedItemsEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionFetchRepeatedItemsEvent(this.collectionId) : super([collectionId]);
}

class CollectionToggleFavEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionToggleFavEvent(this.collectionId) : super([collectionId]);
}
