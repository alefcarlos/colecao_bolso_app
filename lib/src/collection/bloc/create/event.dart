import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import '../../collection_item_model.dart';

// class CollectionFetchAllEvent extends BlocBaseEvent {}

class CollectionItemCreateEvent extends BlocBaseEvent {
  final CollectionItem entity;

  CollectionItemCreateEvent(this.entity) : super([entity]);
}
