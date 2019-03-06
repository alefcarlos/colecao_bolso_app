import 'package:flutter/material.dart';
import 'service_provider.dart';

/// A Flutter [Widget] that merges multiple [ServiceProvider] widgets into one widget tree.
///
/// [ServiceProviderTree] improves the readability and eliminates the need
/// to nest multiple [ServiceProvider].
class ServiceProviderTree extends StatelessWidget {
  /// The [ServiceProvider] list which is converted into a tree of [ServiceProvider] widgets.
  /// The tree of [ServiceProvider] widgets is created in order meaning the first [ServiceProvider]
  /// will be the top-most [ServiceProvider] and the last [ServiceProvider] will be a direct ancestor
  /// of the `child` [Widget].
  final List<ServiceProvider> providers;

  /// The [Widget] and its descendants which will have access to the [Service].
  final Widget child;

  ServiceProviderTree({
    Key key,
    @required this.providers,
    @required this.child,
  })  : assert(providers != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final provider in providers.reversed) {
      tree = provider.copyWith(tree);
    }
    return tree;
  }
}
