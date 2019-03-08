import 'package:bloc/bloc.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:colecao_bolso_app/application/service/service.dart';
import 'package:colecao_bolso_app/src/tags/tags.dart';

import 'src/collections/exporter.dart';
import 'src/collection/exporter.dart';
import 'src/config/app_config.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  runApp(ColecaoDeBolsoApp(
    tagsService: TagsService(),
    collectionsService: CollectionsService(),
    collectionService: CollectionService(),
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ServiceProviderTree(
      providers: [
        ServiceProvider<CollectionService>(service: widget.collectionService),
        ServiceProvider<CollectionsService>(service: widget.collectionsService),
        ServiceProvider<TagsService>(service: widget.tagsService)
      ],
      child: DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              primarySwatch: Colors.deepPurple,
              primaryTextTheme: TextTheme(
                title: TextStyle(color: Colors.white),
              ),
              primaryIconTheme: IconThemeData(color: Colors.white),
              tabBarTheme: TabBarTheme(labelColor: Colors.white),
              accentColor: Colors.deepPurpleAccent,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'Coleção de Bolso',
            theme: theme,
            onGenerateRoute: Application.router.generator,
          );
        },
      ),
    );
  }
}
