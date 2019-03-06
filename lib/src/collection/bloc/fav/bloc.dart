import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import 'state.dart';
import 'event.dart';
import '../../collection_service.dart';
import 'dart:async';

class CollectionFavItemsBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionService _service;
  CollectionFavItemsBloc(this._service);

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
    if (event is CollectionFetchFavItemsEvent) {
      try {
        yield BlocLoadingIndicatorState();
        var data = await _service.fetchFav(event.collectionId);
        yield CollectionItemsLoadedFavState(data);
      } catch (e) {
        yield BlocErrorState(e);
      }
    }
  }

  static CollectionFavItemsBloc of(BuildContext context) =>
      BlocProvider.of<CollectionFavItemsBloc>(context);
}
