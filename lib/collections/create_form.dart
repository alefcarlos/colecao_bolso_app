import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'collection_model.dart';
import 'bloc/create/exporter.dart';
import '../bloc/exporter.dart';
import '../common/common.dart';

class CollectionCreateForm extends StatefulWidget {
  final CreateCollectionBloc bloc;

  CollectionCreateForm(this.bloc);

  @override
  _CollectionCreateFormState createState() => _CollectionCreateFormState();
}

class _CollectionCreateFormState extends State<CollectionCreateForm> {
  String _name = '';
  int _totalItems = 0;
  bool _isFavorite = false;

  _addCollection() {
    var entity = Collection(0, _name, _isFavorite, _totalItems);

    widget.bloc.dispatch(CreateCollectionEvent(entity));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _buildSubmitButton(BuildContext context, BlocBaseState state) {
    if (state is CreateCollectionCreatingState) {
      return LoadingIndicator();
    }

    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () => _addCollection(),
      child: Text('Salvar'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: widget.bloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is CreateCollectionCreatingFailedState) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        if (state is CreateCollectionCreatingSuccessfulState) {
          _onWidgetDidBuild(() {
            Navigator.pop(context, state.collectionId);
          });
        }

        return Container(
          margin: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      filled: true,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    decoration: InputDecoration(
                      labelText: 'Quantidade de itens',
                      filled: true,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _totalItems = int.parse(value);
                      });
                    },
                  ),
                  SwitchListTile(
                    value: _isFavorite,
                    title: Text('Marcar como favorito'),
                    onChanged: (bool value) {
                      setState(() {
                        _isFavorite = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildSubmitButton(context, state)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
