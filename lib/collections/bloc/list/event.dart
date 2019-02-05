import 'package:equatable/equatable.dart';
import '../../collection_model.dart';

abstract class CollectionsEvent extends Equatable {
  CollectionsEvent([List props = const []]) : super(props);
}

class CollectionsFetchEvent extends CollectionsEvent {}

class CollectionsDeleteEvent extends CollectionsEvent {
  final int collectionId;
  CollectionsDeleteEvent(this.collectionId): super([collectionId]);
}

class CollectionsToggleFavEvent extends CollectionsEvent {
  final int collectionId;
  CollectionsToggleFavEvent(this.collectionId): super([collectionId]);
}

class CollectionsCreateEvent extends CollectionsEvent {
  final Collection entity;
  CollectionsCreateEvent(this.entity): super([entity]);
}