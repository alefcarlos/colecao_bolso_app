import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../collections_service.dart';
import '../../../bloc/exporter.dart';
import 'event.dart';
import 'state.dart';

class CollectionsSearchBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionsService _service;

  CollectionsSearchBloc(this._service) : assert(_service != null);

  @override
  UnintializedPageState get initialState => UnintializedPageState();

  @override
  Stream<BlocBaseState> mapEventToState(
      BlocBaseState currentState, BlocBaseEvent event) async* {
    if (event is TextChangedEvent) {
      final String searchTerm = event.term;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield BlocLoadingIndicatorState();
        try {
          var data = await _service.search(event.term);
          yield SearchStateSuccessState(data);
        } catch (error) {
          yield BlocErrorState('something went wrong');
        }
      }
    }
  }

  static CollectionsSearchBloc of(BuildContext context) =>
      BlocProvider.of<CollectionsSearchBloc>(context);
}
