import 'package:bloc/bloc.dart';

import '../../../bloc/exporter.dart';
import 'state.dart';
import 'event.dart';

class MyBloc extends Bloc<BlocBaseEvent, BlocBaseState> {
  @override
  BlocBaseState get initialState => LoadingCollectionsState();

  @override
  Stream<BlocBaseState> mapEventToState(BlocBaseState currentState, BlocBaseEvent event) async* {
    
    if (event is CollectionCreateFetchCollectionsEvent){
      yield
    }

  }
}