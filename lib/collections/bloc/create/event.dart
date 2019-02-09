import '../../collection_model.dart';
import '../../../bloc/exporter.dart';

// class CreateCollectionFetchCollectionsEvent extends BlocBaseEvent {}

class CreateCollectionClearStateEvent extends BlocBaseEvent{}

class CreateCollectionEvent extends BlocBaseEvent {
  final Collection entity;
  CreateCollectionEvent(this.entity) : super([entity]);
}
