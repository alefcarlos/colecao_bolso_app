import 'package:colecao_bolso_app/application/service/service.dart';
import 'package:flutter/material.dart';

class ServiceProvider<T extends ServiceBase> extends InheritedWidget {
  /// The [Service] which is to be made available throughout the subtree
  final T service;

  /// The [Widget] and its descendants which will have access to the [Service].
  final Widget child;

  ServiceProvider({
    Key key,
    @required this.service,
    this.child,
  })  : assert(service != null),
        super(key: key);

  /// Method that allows widgets to access the bloc as long as their `BuildContext`
  /// contains a `ServicesProvider` instance.
  static T of<T extends ServiceBase>(BuildContext context) {
    final type = _typeOf<ServiceProvider<T>>();
    final ServiceProvider<T> provider = context
        .ancestorInheritedElementForWidgetOfExactType(type)
        ?.widget as ServiceProvider<T>;

    if (provider == null) {
      throw FlutterError(
        """
        ServicesProvider.of() called with a context that does not contain a Bloc of type $T.
        No ancestor could be found starting from the context that was passed to ServicesProvider.of<$T>().
        This can happen if the context you use comes from a widget above the ServicesProvider.
        This can also happen.
        The context used was: $context
        """,
      );
    }
    return provider?.service;
  }

  /// Necessary to obtain generic [Type]
  /// https://github.com/dart-lang/sdk/issues/11923
  static Type _typeOf<T>() => T;

  /// Clone the current [ServiceProvider] with a new child [Widget].
  /// All other values, including [Key] and [Service] are preserved.
  ServiceProvider<T> copyWith(Widget child) {
    return ServiceProvider<T>(
      key: key,
      service: service,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(ServiceProvider oldWidget) => false;
}
