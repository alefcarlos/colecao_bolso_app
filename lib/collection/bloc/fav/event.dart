import '../../../bloc/exporter.dart';

class CollectionFetchFavItemsEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionFetchFavItemsEvent(this.collectionId) : super([collectionId]);
}
