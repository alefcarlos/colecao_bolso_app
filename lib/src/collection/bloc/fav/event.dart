import 'package:colecao_bolso_app/application/bloc/bloc.dart';

class CollectionFetchFavItemsEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionFetchFavItemsEvent(this.collectionId) : super([collectionId]);
}
