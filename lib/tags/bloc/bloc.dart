import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'event.dart';
import 'state.dart';
import '../tags_service.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final TagsService _service;

  TagsBloc(this._service) : assert(_service != null);

  @override
  Stream<TagsEvent> transform(Stream<TagsEvent> events) {
    return (events as Observable<TagsEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  TagsState get initialState => TagsLoadingState();

  @override
  Stream<TagsState> mapEventToState(
      TagsState currentState, TagsEvent event) async* {
    if (event == TagsEvent.fetch) {
      yield TagsLoadingState();

      try {
        var result = await _service.fetch(10);
        yield TagsLoadedState(tags: result);
      } catch (e) {
        print(e);
        yield TagsErrorState(e);
      }
    }
  }

  static TagsBloc of(BuildContext context) =>
      BlocProvider.of<TagsBloc>(context);
}
