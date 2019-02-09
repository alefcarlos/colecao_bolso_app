import 'package:bloc/bloc.dart';
import '../../../bloc/exporter.dart';
import 'state.dart';
import 'event.dart';
import '../../collections_service.dart';

class CreateCollectionBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  final CollectionsService _service;

  CreateCollectionBloc(this._service) : assert(_service != null);

  @override
  BlocBaseState get initialState => CreateCollectionUnintialized();

  @override
  Stream<BlocBaseState> mapEventToState(
      BlocBaseState currentState, BlocBaseEvent event) async* {
    // if (event is CreateCollectionFetchCollectionsEvent) {
    //   yield CreateLoadingCollectionsState();
    //   var data = await _service.fetchAll();
    //   yield CreateCollectionsLoadedState(data: data);
    // }

    if (event is CreateCollectionClearStateEvent) {
      yield CreateCollectionUnintialized();
    }

    if (event is CreateCollectionEvent) {
      try {
        yield CreateCollectionCreatingState();
        await _service.add(event.entity);
        yield CreateCollectionCreatingSuccessfulState(event.entity.id);
      } catch (e) {
        yield CreateCollectionCreatingFailedState(
            'Não foi possível criar a coleção, tente novamente.');
      }
    }
  }
}
