import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import './collections/exporter.dart';
import './tags/exporter.dart';
import './collection/exporter.dart';
import './config/app_config.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  runApp(ColecaoDeBolsoApp(
    tagsService: TagsService(httpClient: http.Client()),
    collectionsService: CollectionsService(httpClient: http.Client()),
    collectionService: CollectionService(httpClient: http.Client()),
  ));
}

class ColecaoDeBolsoApp extends StatefulWidget {
  final TagsService tagsService;
  final CollectionsService collectionsService;
  final CollectionService collectionService;

  ColecaoDeBolsoApp(
      {@required this.tagsService,
      @required this.collectionsService,
      @required this.collectionService}) {
    final router = new Router();

    //Configurar rotas
    Routes.configureRoutes(router);
    CollectionRoute.configureRoutes(router);
    CollectionsRoute.configureRoutes(router);
    TagsRoute.configureRoutes(router);

    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() => _ColecaoDeBolsoAppState();
}

class _ColecaoDeBolsoAppState extends State<ColecaoDeBolsoApp> {
  TagsBloc tagsBloc;
  CollectionsBloc collectionsBloc;
  CreateCollectionBloc createCollectionBloc;
  CollectionBloc collectionBloc;
  CollectionFavItemsBloc collectionFavItemsBloc;
  CollectionRepeatedItemsBloc collectionRepeatedItemsBloc;

  @override
  void initState() {
    tagsBloc = TagsBloc(widget.tagsService);
    collectionsBloc = CollectionsBloc(widget.collectionsService);
    createCollectionBloc = CreateCollectionBloc(widget.collectionsService);
    collectionBloc = CollectionBloc(widget.collectionService);
    collectionFavItemsBloc = CollectionFavItemsBloc(widget.collectionService);
    collectionRepeatedItemsBloc =
        CollectionRepeatedItemsBloc(widget.collectionService);
    super.initState();
  }

  @override
  void dispose() {
    tagsBloc.dispose();
    collectionsBloc.dispose();
    createCollectionBloc.dispose();
    collectionBloc.dispose();
    collectionFavItemsBloc.dispose();
    collectionRepeatedItemsBloc.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CollectionsBloc>(bloc: collectionsBloc),
        BlocProvider<CreateCollectionBloc>(bloc: createCollectionBloc),
        BlocProvider<CollectionBloc>(bloc: collectionBloc),
        BlocProvider<CollectionFavItemsBloc>(bloc: collectionFavItemsBloc),
        BlocProvider<CollectionRepeatedItemsBloc>(bloc: collectionRepeatedItemsBloc),
      ],
      child: MaterialApp(
        title: 'Coleção de Bolso',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
          primaryIconTheme: IconThemeData(color: Colors.white),
          tabBarTheme: TabBarTheme(labelColor: Colors.white),
          accentColor: Colors.deepOrangeAccent,
        ),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}

