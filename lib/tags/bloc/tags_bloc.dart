import 'package:bloc/bloc.dart';
import 'tags_event.dart';
import 'tags_state.dart';
import '../tags_service.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final TagsService _service;

  TagsBloc(this._service) : assert(_service != null);

  @override
  TagsState get initialState => TagsIsLoadingState();

  @override
  Stream<TagsState> mapEventToState(
      TagsState currentState, TagsEvent event) async* {

    if (event == TagsEvent.loading) {
      yield TagsIsLoadingState(); 
      print('[TagsEvent.loading]');
      var result = await _service.fetch();
      print('[TagsEvent.loading] - fetched');
      yield TagsIsReadyState(tags: result);
    }
  }
}
