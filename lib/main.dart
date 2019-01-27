import 'package:flutter/material.dart';
import './config/application.dart';
import './config/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/collection.dart';

void main() => runApp(MyApp(collectionModel: CollectionModel()));

class MyApp extends StatelessWidget {
  final CollectionModel collectionModel;

  MyApp({@required this.collectionModel}) {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CollectionModel>(
      model: collectionModel,
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
