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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'name': '',
    'totalItems': 1,
    'isFav': false,
    'color': null
  };

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    var entity = Collection(
        0, _formData['name'], _formData['isFav'], _formData['totalItems']);

    widget.bloc.dispatch(CreateCollectionEvent(entity));
  }

  Widget _buildSubmitButton(BuildContext context, BlocBaseState state) {
    if (state is CreateCollectionCreatingState) {
      return LoadingIndicator();
    }

    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () => _submitForm(),
      child: Text('Salvar'),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nome',
        filled: true,
      ),
      validator: (String value){
        if (value.isEmpty) return 'O campo nome é obrigatório!';
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildTotalItemsField() {
    return TextField(
      keyboardType:
          TextInputType.numberWithOptions(decimal: false, signed: false),
      decoration: InputDecoration(
        labelText: 'Quantidade de itens',
        filled: true,
      ),
      onChanged: (String value) {
        _formData['itemsCount'] = int.parse(value);
      },
    );
  }

  Widget _buildIsFavField() {
    return SwitchListTile(
      value: _formData['isFav'],
      onChanged: (bool value) {
        setState(() {
          _formData['isFav'] = value;
        });
      },
      title: Text('Marcar como favorito'),
    );
  }

  List<Widget> _buildFields(BuildContext context, BlocBaseState state) {
    return [
      _buildNameField(),
      SizedBox(
        height: 10.0,
      ),
      _buildTotalItemsField(),
      SizedBox(
        height: 10.0,
      ),
      _buildIsFavField(),
      SizedBox(
        height: 10.0,
      ),
      SizedBox(
        height: 10.0,
      ),
      _buildSubmitButton(context, state)
    ];
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: _buildFields(context, state),
            ),
          ),
        );
      },
    );
  }
}
