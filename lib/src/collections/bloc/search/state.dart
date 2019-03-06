import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import '../../../collections/collection_model.dart';

class SearchStateEmpty extends BlocBaseState {
  @override
  String toString() => 'SearchStateEmpty';
}

class SearchStateSuccessState extends BlocBaseState {
  final List<Collection> data;
  SearchStateSuccessState(this.data) : super([data]);

  @override
  String toString() => "SearchStateSuccessState, data.lenght(${data.length})";
}
