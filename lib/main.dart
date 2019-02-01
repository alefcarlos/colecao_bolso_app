import 'package:flutter/material.dart';
import './config/application.dart';
import './config/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/collection.dart';
import './scoped_models/collection_item.dart';
import './scoped_models/item_tag.dart';

void main() => runApp(MyApp(
      collectionModel: CollectionModel(),
      collectionItemModel: CollectionItemModel(),
      itemTagModel: ItemTagModel(),
    ));

class MyApp extends StatelessWidget {
  final CollectionModel collectionModel;
  final CollectionItemModel collectionItemModel;
  final ItemTagModel itemTagModel;

  MyApp(
      {@required this.collectionModel,
      @required this.collectionItemModel,
      @required this.itemTagModel}) {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  _injectScopedModels({@required Widget child}) {
    return ScopedModel<CollectionModel>(
      model: collectionModel,
      child: ScopedModel<CollectionItemModel>(
        model: collectionItemModel,
        child: ScopedModel<ItemTagModel>(
          model: itemTagModel,
          child: child,
        ),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _injectScopedModels(
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
    );
  }
}
