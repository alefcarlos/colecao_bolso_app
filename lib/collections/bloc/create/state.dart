import '../../../bloc/state_base.dart';

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

  CreateCollectionCreatingSuccessfulState(this.collectionId)
      : super([collectionId]);

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
