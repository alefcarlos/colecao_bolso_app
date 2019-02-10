import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../bloc/exporter.dart';
import 'state.dart';
import 'event.dart';
import '../../collection_service.dart';

class CollectionBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionService _service;
  CollectionBloc(this._service);

  @override
  Stream<BlocBaseEvent> transform(Stream<BlocBaseEvent> events) {
    return (events as Observable<BlocBaseEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  BlocLoadingIndicatorState get initialState => BlocLoadingIndicatorState();

  @override
  Stream<BlocBaseState> mapEventToState(
      BlocBaseState currentState, BlocBaseEvent event) async* {
    if (event is CollectionFetchItemsEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BlocLoadingIndicatorState) {
          final data = await _service.fetch(event.collectionId, 0, 10);
          yield CollectionItemsLoadedState(data: data, hasReachedMax: false);
        }
        if (currentState is CollectionItemsLoadedState) {
          final data = await _service.fetch(event.collectionId, currentState.data.length, 10);
          yield data.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : CollectionItemsLoadedState(
                  data: currentState.data + data,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        yield BlocErrorState(e);
      }
    }
  }

  bool _hasReachedMax(BlocBaseState state) =>
      state is CollectionItemsLoadedState && state.hasReachedMax;

  static CollectionBloc of(BuildContext context) =>
      BlocProvider.of<CollectionBloc>(context);
}
