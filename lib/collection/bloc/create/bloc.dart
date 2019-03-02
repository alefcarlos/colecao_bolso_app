import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'event.dart';
import 'state.dart';
import '../../../bloc/exporter.dart';
import '../../../collections/collections_service.dart';
import '../../collection_service.dart';

class CreateCollectionItemBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionsService _service;
  final CollectionService _itemService;

  CreateCollectionItemBloc(this._service, this._itemService)
      : assert(_service != null),
        assert(_itemService != null);

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
            'Não foi possível carregar as coleções, tente novamente...');
      }
    }

    if (event is ClearEvent) {
      yield UnintializedPageState();
    }

    if (event is CollectionItemCreateEvent) {
      try {
        yield CreateCollectionItemCreatingState();
        await _itemService.add(event.entity);
        yield CreateCollectionItemCreatingSuccessfulState(event.entity.id);
      } catch (e) {
        yield BlocErrorState(
            'Não foi possível criar o item, tente novamente.');
      }
    }
  }

  static CreateCollectionItemBloc of(BuildContext context) =>
      BlocProvider.of<CreateCollectionItemBloc>(context);
}
