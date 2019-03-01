import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'event.dart';
import 'state.dart';
import '../../../bloc/exporter.dart';
import '../../../collections/collections_service.dart';

class CreateCollectionItemBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionsService _service;

  CreateCollectionItemBloc(this._service) : assert(_service != null);

  @override
  BlocBaseState get initialState => UnintializedPageState();

  @override
  Stream<BlocBaseState> mapEventToState(
      BlocBaseState currentState, BlocBaseEvent event) async* {
    if (event is CollectionFetchAllEvent) {
      try {
        yield BlocLoadingIndicatorState();
        var data = await _service.fetchAll();
        yield CollectionsLoadedAllState(data);
      } catch (e) {
        yield BlocErrorState(
            'Não foipossível carregar as coleções, tente novamente...');
      }
    }
    
    if (event is ClearEvent) {
      yield UnintializedPageState();
    }
  }

  static CreateCollectionItemBloc of(BuildContext context) =>
      BlocProvider.of<CreateCollectionItemBloc>(context);
}
