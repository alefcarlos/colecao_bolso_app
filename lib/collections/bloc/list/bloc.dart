import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'event.dart';
import 'state.dart';
import '../../collections_service.dart';
import '../../collection_model.dart';
import '../../../bloc/exporter.dart';

class CollectionsBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionsService _service;

  CollectionsBloc(this._service) : assert(_service != null);

  @override
  Stream<BlocBaseEvent> transform(Stream<BlocBaseEvent> events) {
    return (events as Observable<BlocBaseEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  BlocBaseState get initialState => CollectionsLoadingState();

  @override
  Stream<BlocBaseState> mapEventToState(
      BlocBaseState currentState, BlocBaseEvent event) async* {

    print('mapEventToState ${event.toString()}');

    if (event is CollectionsDeleteEvent &&
        currentState is CollectionsLoadedState) {
      yield CollectionsLoadingState();
      var data = await _delete(event.collectionId, currentState);
      yield currentState.copyWith(
          data: data, hasReachedMax: currentState.hasReachedMax);
    }

    if (event is CollectionsToggleFavEvent &&
        currentState is CollectionsLoadedState) {
      yield CollectionsLoadingState();
      var data = await _toggleFav(event.collectionId, currentState);
      yield currentState.copyWith(
          data: data, hasReachedMax: currentState.hasReachedMax);
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
        yield BlocErrorState(e);
      }
    }
  }

  Future<List<Collection>> _delete(
      int collectionId, CollectionsLoadedState loadedState) async {
    await _service.delete(collectionId);
    // var deletedItemIndex = loadedState.data.indexWhere((x) => x.id == collectionId);
    // loadedState.data.removeAt(deletedItemIndex);
    return loadedState.data;
  }

  Future<List<Collection>> _toggleFav(
      int collectionId, CollectionsLoadedState loadedState) async {
    await _service.toggleFav(collectionId);
    // var updatedItemIndex = loadedState.data.indexWhere((x) => x.id == collectionId);
    // var isFav = loadedState.data[updatedItemIndex].isFav;
    // loadedState.data[updatedItemIndex].setFav(!isFav);
    return loadedState.data;
  }

  bool _hasReachedMax(BlocBaseState state) =>
      state is CollectionsLoadedState && state.hasReachedMax;

  static CollectionsBloc of(BuildContext context) =>
      BlocProvider.of<CollectionsBloc>(context);
}
