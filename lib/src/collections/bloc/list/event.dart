import 'package:colecao_bolso_app/application/bloc/bloc.dart';

class CollectionsFetchEvent extends BlocBaseEvent {
  final bool fromScroll;
  CollectionsFetchEvent({this.fromScroll = false}) : super([fromScroll]);
}

class CollectionsDeleteEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionsDeleteEvent(this.collectionId) : super([collectionId]);
}

class CollectionsToggleFavEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionsToggleFavEvent(this.collectionId) : super([collectionId]);
}
