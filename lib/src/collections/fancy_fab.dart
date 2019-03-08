import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:colecao_bolso_app/application/shared/shared.dart';

import '../config/app_config.dart';
import '../collection/route_handler.dart';
import 'route_handler.dart';
import 'bloc/list/exporter.dart';

class CollectionsPageFab extends StatelessWidget {
  final CollectionsBloc bloc;
  CollectionsPageFab(this.bloc);

  @override
  Widget build(BuildContext context) {
    return UnicornDialer(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
      parentButtonBackground: Theme.of(context).accentColor,
      orientation: UnicornOrientation.VERTICAL,
      parentButton: Icon(Icons.more_vert),
      childButtons: [
        UnicornButton(
          hasLabel: true,
          labelText: "Adicionar coleção",
          currentButton: FloatingActionButton(
            heroTag: "addCollection",
            backgroundColor: Colors.blue,
            mini: true,
            child: Icon(Icons.add),
            onPressed: () {
              Application.router
                  .navigateTo(context, CollectionsRoute.createCollectionRoute)
                  .then((createdId) {
                if (createdId != null) {
                  bloc.dispatch(CollectionsFetchEvent());

                  showSnackBar(
                    context,
                    'Coleção criada com sucesso',
                    action: SnackBarAction(
                      label: 'Ver coleção',
                      onPressed: () => Application.router
                          .navigateTo(context, '/collection/$createdId'),
                    ),
                  );
                }
              });
            },
          ),
        ),
        UnicornButton(
          hasLabel: true,
          labelText: "Adicionar Item",
          currentButton: FloatingActionButton(
            heroTag: "addItem",
            backgroundColor: Colors.green,
            mini: true,
            child: Icon(Icons.camera_enhance),
            onPressed: () {
              Application.router
                  .navigateTo(context, CollectionRoute.createItemRoute)
                  .then((result) => result != null
                      ? showSnackBar(
                          context,
                          'Item criado com sucesso',
                          action: SnackBarAction(
                            label: 'Ver item',
                            onPressed: () => Application.router.navigateTo(
                                context, '/collection/${result.collectionId}'),
                          ),
                        )
                      : null);
            },
          ),
        )
      ],
    );
  }
}
