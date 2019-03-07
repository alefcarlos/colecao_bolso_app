import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './fancy_fab.dart';
import 'drawer.dart';
import 'collections_list.dart';
import 'bloc/list/exporter.dart';
import 'collections_service.dart';

class CollectionsPage extends StatefulWidget {
  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  CollectionsBloc _bloc;

  void initState() {
    _bloc = CollectionsBloc(CollectionsService.of(context));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: Scaffold(
        drawer: CollectionsDrawer(),
        appBar: AppBar(
          title: Text('Minhas coleções'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings_brightness),
                tooltip: 'Alterar tema',
                onPressed: () {
                  DynamicTheme.of(context).setBrightness(
                      Theme.of(context).brightness == Brightness.dark
                          ? Brightness.light
                          : Brightness.dark);
                }),
          ],
        ),
        body: CollectionsList(_bloc),
        floatingActionButton: CollectionsPageFab(_bloc),
      ),
    );
  }
}
