import 'package:equatable/equatable.dart';

abstract class BlocBaseEvent extends Equatable {
  BlocBaseEvent([List props = const []]) : super(props);
}

class ClearEvent extends BlocBaseEvent {}
