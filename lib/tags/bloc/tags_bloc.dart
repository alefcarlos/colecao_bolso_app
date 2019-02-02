import 'package:bloc/bloc.dart';
import 'tags_event.dart';
import 'tags_state.dart';
import '../tags_service.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final TagsService _service;

  TagsBloc(this._service) : assert(_service != null);

  @override
  TagsState get initialState => TagsLoadingState();

  @override
  Stream<TagsState> mapEventToState(
      TagsState currentState, TagsEvent event) async* {
    if (event == TagsEvent.loading) {
      yield TagsLoadingState();

      try {
        var result = await _service.fetch();
        yield TagsLoadedState(tags: result);
      } catch (e) {
        print(e);
        yield TagsErrorState(e);
      }
    }
  }
}
