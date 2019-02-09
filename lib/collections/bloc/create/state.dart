import 'package:meta/meta.dart';

import '../../../bloc/state_base.dart';
import '../../collection_model.dart';

// class CreateLoadingCollectionsState extends BlocBaseState {
//   @override
//   String toString() {
//     return "LoadingCollectionsState";
//   }
// }

// class CreateCollectionsLoadedState extends BlocBaseState {
//   final List<Collection> data;

//   CreateCollectionsLoadedState({
//     @required this.data,
//   })  : assert(data != null),
//         super([data]);

//   @override
//   String toString() =>
//       "CreateCollectionsLoadedState, data.lenght(${data.length})";
// }

class CreateCollectionUnintialized extends BlocBaseState {
  @override
  String toString() {
    return "CreateCollectionUnintialized";
  }
}

class CreateCollectionCreatingState extends BlocBaseState {
  @override
  String toString() {
    return "CreateCollectionCreating";
  }
}

class CreateCollectionCreatingSuccessfulState extends BlocBaseState {
  final int collectionId;
  
  CreateCollectionCreatingSuccessfulState(this.collectionId): super([collectionId]);

  @override
  String toString() {
    return "CreateCollectionCreatingSuccessfulState";
  }
}

class CreateCollectionCreatingFailedState extends BlocBaseState {
  final String error;
  CreateCollectionCreatingFailedState(this.error) : super([error]);

  @override
  String toString() {
    return "CreateCollectionCreatingFailedState";
  }
}
