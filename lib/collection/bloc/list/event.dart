import '../../../bloc/exporter.dart';

class CollectionFetchItemsEvent extends BlocBaseEvent {
  final int collectionId;
  final bool fromScroll;
  CollectionFetchItemsEvent(this.collectionId, this.fromScroll) : super([collectionId, fromScroll]);
}

class CollectionToggleFavEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionToggleFavEvent(this.collectionId) : super([collectionId]);
}
