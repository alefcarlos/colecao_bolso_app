import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../bloc/exporter.dart';
import 'state.dart';
import 'event.dart';
import '../../collection_service.dart';
import 'dart:async';

class CollectionRepeatedItemsBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionService _service;
  CollectionRepeatedItemsBloc(this._service);

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
    if (event is CollectionFetchRepeatedItemsEvent) {
      try {
        yield BlocLoadingIndicatorState();
        var data = await _service.fetchRepeated(event.collectionId);
        yield CollectionItemsLoadedRepeatedState(data);
      } catch (e) {
        yield BlocErrorState(e);
      }
    }
  }

  static CollectionRepeatedItemsBloc of(BuildContext context) =>
      BlocProvider.of<CollectionRepeatedItemsBloc>(context);
}
