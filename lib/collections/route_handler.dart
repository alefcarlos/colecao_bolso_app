import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './collections_page.dart';
import './create.dart';
import 'bloc/list/export.dart';

class CollectionsRoute {
  static String collectionsRoute = '/collections';
  static String createCollectionRoute = '/collections/create';

  static final collectionsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {

    var collectionsBloc = BlocProvider.of<CollectionsBloc>(context);
    collectionsBloc.dispatch(CollectionsFetchEvent());
    return CollectionsPage(collectionsBloc);
  });

  static final createCollectionHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        var collectionsBloc = BlocProvider.of<CollectionsBloc>(context);
    return CreateCollectionPage(collectionsBloc);
  });

  static void configureRoutes(Router router) {
    router.define(collectionsRoute, handler: collectionsHandler);
    router.define(createCollectionRoute, handler: createCollectionHandler);
  }
}
