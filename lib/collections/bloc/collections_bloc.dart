import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'collections_event.dart';
import 'collections_state.dart';
import '../collections_service.dart';
import '../collection_model.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final CollectionsService _service;

  CollectionsBloc(this._service) : assert(_service != null);

  //TODO: entender melhor o que isso faz.
  @override
  Stream<CollectionsEvent> transform(Stream<CollectionsEvent> events) {
    return (events as Observable<CollectionsEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  CollectionsState get initialState => CollectionsLoadingState();

  @override
  Stream<CollectionsState> mapEventToState(
      CollectionsState currentState, CollectionsEvent event) async* {
    if (event is CollectionsDeleteEvent && currentState is CollectionsLoadedState) {
      yield CollectionsLoadingState();
      var data = await _delete(event.collectionId, currentState);
      yield currentState.copyWith(data: data, hasReachedMax: currentState.hasReachedMax);
    }

    if (event is CollectionsToggleFavEvent&& currentState is CollectionsLoadedState) {
      yield CollectionsLoadingState();
      var data = await _toggleFav(event.collectionId, currentState);
      yield currentState.copyWith(data: data, hasReachedMax: currentState.hasReachedMax);
    }

    if (event is CollectionsFetchEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is CollectionsLoadingState) {
          final collections = await _service.fetch(0, 10);
          yield CollectionsLoadedState(data: collections, hasReachedMax: false);
        }
        if (currentState is CollectionsLoadedState) {
          final posts = await _service.fetch(currentState.data.length, 10);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : CollectionsLoadedState(
                  data: currentState.data + posts,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        yield CollectionsErrorState(e);
      }
    }
  }

  Future<List<Collection>> _delete(int collectionId, CollectionsLoadedState loadedState) async {
    await _service.delete(collectionId);
    var deletedItemIndex = loadedState.data.indexWhere((x) => x.id == collectionId);
    loadedState.data.removeAt(deletedItemIndex);
    return loadedState.data;
  }

  Future<List<Collection>> _toggleFav(int collectionId, CollectionsLoadedState loadedState) async {
    await _service.toggleFav(collectionId);
    var updatedItemIndex = loadedState.data.indexWhere((x) => x.id == collectionId);
    var isFav = loadedState.data[updatedItemIndex].isFav;
    loadedState.data[updatedItemIndex].setFav(!isFav);
    return loadedState.data;
  }

  bool _hasReachedMax(CollectionsState state) =>
      state is CollectionsLoadedState && state.hasReachedMax;
}
