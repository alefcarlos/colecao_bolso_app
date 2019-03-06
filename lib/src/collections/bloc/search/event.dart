import 'package:colecao_bolso_app/application/bloc/bloc.dart';

class TextChangedEvent extends BlocBaseEvent {
  final String term;
  TextChangedEvent(this.term) : super([term]);
}
