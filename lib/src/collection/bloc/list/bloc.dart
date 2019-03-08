import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import 'state.dart';
import 'event.dart';
import '../../collection_service.dart';
import '../../collection_item_model.dart';
import 'dart:async';

class CollectionBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionService service;
  CollectionBloc(this.service);

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
    if (event is CollectionFetchItemsEvent) {
      if (!event.fromScroll) yield BlocLoadingIndicatorState();

      if (event.fromScroll && _hasReachedMax(currentState)) return;
      try {
        if (currentState is BlocLoadingIndicatorState) {
          final data = await service.fetch(event.collectionId, 0, 10);
          yield CollectionItemsLoadedState(data: data,  hasReachedMax: true);
        }
        if (currentState is CollectionItemsLoadedState) {
          final data = await service.fetch(event.collectionId,
              !event.fromScroll ? 0 : currentState.data.length, 10);

          if (!event.fromScroll && data.isEmpty)
            yield CollectionItemsLoadedState(
              data: [],
              hasReachedMax: true,
            );
          else if (!event.fromScroll && data.isNotEmpty) {
            yield CollectionItemsLoadedState(
              data: data,
              hasReachedMax: false,
            );
          } else if (event.fromScroll) {
            yield data.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : CollectionItemsLoadedState(
                    data: currentState.data + data,
                    hasReachedMax: false,
                  );
          }
        }
      } catch (e) {
        yield BlocErrorState(e);
      }
    }

    if (event is CollectionToggleFavEvent &&
        currentState is CollectionItemsLoadedState) {
      try {
        yield BlocLoadingIndicatorState();
        var data = await _toggleFav(event.collectionId, currentState);
        yield currentState.copyWith(
            data: data, hasReachedMax: currentState.hasReachedMax);
      } catch (e) {
        yield BlocErrorState(
            'Não foipossível carregar os itens, tente novamente...');
      }
    }
  }

  bool _hasReachedMax(BlocBaseState state) =>
      state is CollectionItemsLoadedState && state.hasReachedMax;

  Future<List<CollectionItem>> _toggleFav(
      int itemId, CollectionItemsLoadedState loadedState) async {
    await service.toggleFav(itemId);
    // var updatedItemIndex = loadedState.data.indexWhere((x) => x.id == itemId);
    // var isFav = loadedState.data[updatedItemIndex].isFav;
    // loadedState.data[updatedItemIndex].setFav(!isFav);
    return loadedState.data;
  }

  static CollectionBloc of(BuildContext context) =>
      BlocProvider.of<CollectionBloc>(context);
}
