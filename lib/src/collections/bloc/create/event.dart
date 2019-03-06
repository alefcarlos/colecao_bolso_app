import '../../collection_model.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';

// class CreateCollectionFetchCollectionsEvent extends BlocBaseEvent {}

class CreateCollectionEvent extends BlocBaseEvent {
  final Collection entity;
  CreateCollectionEvent(this.entity) : super([entity]);
}
