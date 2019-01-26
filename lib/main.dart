import 'package:flutter/material.dart';
import './entities/collectionEntity.dart';
import './config/application.dart';
import './config/routes.dart';
import 'package:fluro/fluro.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<CollectionEntity> tempData = [
    CollectionEntity(1, 'Bonequinhos'),
    CollectionEntity(2, 'Mangás', isFav: true)
  ];

  _deleteCollection(index) {
    setState(() {
      tempData.removeAt(index);
    });
  }

  _createCollection(CollectionEntity entity) {
    setState(() {
      tempData.add(entity);
    });
  }

  _MyAppState() {
    final router = new Router();
    Routes.configureRoutes(
        router, tempData, _deleteCollection, _createCollection);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white
        ),
        accentColor: Colors.deepOrangeAccent,
      ),
      // home: AuthPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
