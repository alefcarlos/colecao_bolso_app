import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import 'package:colecao_bolso_app/application/shared/shared.dart';

import '../../widgets/forms-input/image.dart';
import '../collection_item_model.dart';
import '../bloc/create/exporter.dart';
import 'create_result_model.dart';
import '../../config/app_config.dart';

class CreateCollectionItemForm extends StatefulWidget {
  /// É possível criamos um item para uma determinada coleção, basta informar o ID da mesma
  final int collectionId;
  final CreateCollectionItemBloc bloc;

  CreateCollectionItemForm(this.collectionId, this.bloc);

  _CreateCollectionItemFormState createState() =>
      _CreateCollectionItemFormState();
}

class _CreateCollectionItemFormState extends State<CreateCollectionItemForm> {
  int _selectedCollectionId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'number': '',
    'quantity': 1,
    'isFav': false
  };
  List<String> _tags = [];
  FocusNode quantityFocusNode;

  CreateCollectionItemBloc get bloc => widget.bloc;

  @override
  void initState() {
    quantityFocusNode = FocusNode();
    _selectedCollectionId = widget.collectionId;
    _tags = [];
    super.initState();
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (_selectedCollectionId == null) {
      showSnackBar(context, 'É obrigatório selecionar uma coleção!');
      return;
    }

    _formKey.currentState.save();
    var entity = CollectionItem(_selectedCollectionId, _formData['number'],
        _formData['isFav'], _formData['quantity'], _tags);

    bloc.dispatch(CollectionItemCreateEvent(entity));
  }

  Widget _buildNumberTextField() {
    return TextFormField(
      autofocus: true,
      initialValue: _formData['number'].toString(),
      decoration: InputDecoration(
        labelText: 'Nº do item',
      ),
      textInputAction: TextInputAction.next,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Informe valor válido.';
        }
      },
      onSaved: (String value) {
        _formData['number'] = value;
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty)
          FocusScope.of(context).requestFocus(quantityFocusNode);
        else {
          showSnackBar(context, 'Informe um número para seu item!');
        }
      },
    );
  }

  Widget _buildQuantityTextField() {
    return TextFormField(
      focusNode: quantityFocusNode,
      initialValue: _formData['quantity'].toString(),
      decoration: InputDecoration(
        labelText: 'Quantidade',
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty || int.parse(value) <= 0) {
          return 'Quantidade dever ser maior ou igual a 1.';
        }
      },
      onSaved: (String value) {
        _formData['quantity'] = int.parse(value);
      },
    );
  }

  Widget _buildIsFavSwitch() {
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

  Widget _buildTagsInput() {
    return InputTags(
      tags: [],
      placeholder: 'Adicione tags ao seu item',
      lowerCase: true,
      onDelete: (tag) {
        setState(() {
          _tags.removeWhere((item) => item == tag);
        });
      },
      onInsert: (tag) {
        setState(() {
          _tags.add(tag);
        });
      },
    );
  }

  List<Widget> _buildFields(BuildContext context, BlocBaseState state) {
    return <Widget>[
      RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: () {
            Application.router.navigateTo(context, '/collections/search').then(
              (result) {
                if (result != null) {
                  setState(() {
                    _selectedCollectionId = result;
                  });
                }
              },
            );
          },
          child: Text(
            'Selecionar coleção',
          )),
      _buildNumberTextField(),
      SizedBox(
        height: 10.0,
      ),
      _buildQuantityTextField(),
      SizedBox(
        height: 10.0,
      ),
      _buildIsFavSwitch(),
      SizedBox(
        height: 10.0,
      ),
      _buildTagsInput(),
      ImageInput(),
      SizedBox(
        height: 10.0,
      ),
      _buildSubmitButton(context, state)
    ];
  }

  Widget _buildSubmitButton(BuildContext context, BlocBaseState state) {
    if (state is CreateCollectionItemCreatingState) {
      return LoadingIndicator();
    }

    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () => _submitForm(context),
      child: Text('Salvar'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: bloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is BlocErrorState) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        if (state is CreateCollectionItemCreatingSuccessfulState) {
          _onWidgetDidBuild(() {
            bloc.dispatch(ClearEvent());
            Navigator.pop(
              context,
              CreateItemResult(_selectedCollectionId, state.collectionItemId),
            );
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
