import '../../../bloc/event_base.dart';

class TextChangedEvent extends BlocBaseEvent {
  final String term;
  TextChangedEvent(this.term) : super([term]);
}
