import 'package:flutter/material.dart';
import './pages/collection/collection_tabs.dart';
import './pages/collections/collections.dart';
import './entities/collectionEntity.dart';

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
      ),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) =>
            CollectionsPage(tempData, _deleteCollection),
      },
      onGenerateRoute: (RouteSettings settings) {
        final pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;

        if (pathElements[1] == 'collections') {
          final index = int.parse(pathElements[2]);
          return MaterialPageRoute<Widget>(
              builder: (BuildContext context) =>
                  CollectionPage(tempData, index));
        }

        return null;
      },
    );
  }
}
