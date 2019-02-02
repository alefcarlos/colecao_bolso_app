import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'collections_event.dart';
import 'collections_state.dart';
import '../collections_service.dart';

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
  CollectionsState get initialState => CollectionsUninitializedState();

  @override
  Stream<CollectionsState> mapEventToState(
      CollectionsState currentState, CollectionsEvent event) async* {
    if (event == CollectionsEvent.fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is CollectionsUninitializedState) {
          yield CollectionsLoadingState();
          final collections = await _service.fetch(0, 5);
          yield CollectionsLoadedState(data: collections, hasReachedMax: false);
        }
        if (currentState is CollectionsLoadedState) {
          // yield CollectionsLoadingState();
          final posts = await _service.fetch(currentState.data.length, 5);
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

  bool _hasReachedMax(CollectionsState state) =>
      state is CollectionsLoadedState && state.hasReachedMax;
}
