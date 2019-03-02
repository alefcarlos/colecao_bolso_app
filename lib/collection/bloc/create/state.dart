import '../../../bloc/state_base.dart';
import '../../../collections/collection_model.dart';

class UnintializedPageState extends BlocBaseState {}

class CollectionsLoadedAllState extends BlocBaseState {
  final List<Collection> data;
  CollectionsLoadedAllState(this.data) : super([data]);

  @override
  String toString() => "CollectionsLoadedAllState, data.lenght(${data.length})";
}

class CreateCollectionItemCreatingState extends BlocBaseState{}

class CreateCollectionItemCreatingSuccessfulState extends BlocBaseState {
  final int collectionItemId;

  CreateCollectionItemCreatingSuccessfulState(this.collectionItemId)
      : super([collectionItemId]);

  @override
  String toString() {
    return "CreateCollectionItemCreatingSuccessfulState";
  }
}