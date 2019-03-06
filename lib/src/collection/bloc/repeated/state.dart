import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import '../../collection_item_model.dart';

class CollectionItemsLoadedRepeatedState extends BlocBaseState {
  final List<CollectionItem> data;
  CollectionItemsLoadedRepeatedState(this.data) : super([data]);

  @override
  String toString() =>
      "CollectionItemsLoadedRepeatedState, data.length(${data.length})";
}
