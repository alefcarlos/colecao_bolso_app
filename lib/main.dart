import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';

import './collections/collections.dart';
import './tags/tags.dart';
import './collection/collection.dart';
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
    collectionModel: CollectionModel(),
    collectionItemModel: CollectionItemModel(),
    itemTagModel: ItemTagModel(),
    tagsService: TagsService(),
  ));
}

class ColecaoDeBolsoApp extends StatefulWidget {
  final CollectionModel collectionModel;
  final CollectionItemModel collectionItemModel;
  final ItemTagModel itemTagModel;
  final TagsService tagsService;

  ColecaoDeBolsoApp({
    @required this.collectionModel,
    @required this.collectionItemModel,
    @required this.itemTagModel,
    @required this.tagsService,
  }) {
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

  @override
  void initState() {
    tagsBloc = TagsBloc(widget.tagsService);
    super.initState();
  }

  @override
  void dispose() {
    tagsBloc.dispose();
    super.dispose();
  }

  _injectScopedModels({@required Widget child}) {
    return ScopedModel<CollectionModel>(
      model: widget.collectionModel,
      child: ScopedModel<CollectionItemModel>(
        model: widget.collectionItemModel,
        child: ScopedModel<ItemTagModel>(
          model: widget.itemTagModel,
          child: child,
        ),
      ),
    );
  }

  _injectBloc({@required Widget child}) {
    return BlocProvider<TagsBloc>(
      bloc: tagsBloc,
      child: child,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _injectScopedModels(
      child: _injectBloc(
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
          // home: AuthPage(),
          onGenerateRoute: Application.router.generator,
        ),
      ),
    );
  }
}
