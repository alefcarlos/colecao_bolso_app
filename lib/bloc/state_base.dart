import 'package:equatable/equatable.dart';

abstract class BlocBaseState extends Equatable {
  BlocBaseState([List props = const []]) : super(props);
}
class BlocLoadingIndicatorState extends BlocBaseState {}

class BlocErrorState extends BlocBaseState {
  final String error;
  BlocErrorState(this.error)
      : assert(error != null && error.isNotEmpty),
        super([error]);

  @override
  String toString() => "BlocErrorState";
}