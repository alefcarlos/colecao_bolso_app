import 'package:colecao_bolso_app/application/bloc/bloc.dart';

class CollectionFetchRepeatedItemsEvent extends BlocBaseEvent {
  final int collectionId;
  CollectionFetchRepeatedItemsEvent(this.collectionId) : super([collectionId]);
}
