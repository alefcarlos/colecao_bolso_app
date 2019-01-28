import 'package:flutter/material.dart';
import '../../config/application.dart';
import '../../scoped_models/collection.dart';
import '../../scoped_models/collection_item.dart';
import '../../models/collection_item.dart';

class EditCollectionItemPage extends StatefulWidget {
  /// É possível criamos um item para uma determinada coleção, basta informar o ID da mesma
  final int collectionId;

  /// Quando collectionId for nulo, deve ser passado valor
  final CollectionModel collectionModel;

  final CollectionItemModel collectionItemModel;

  EditCollectionItemPage(
      {this.collectionId,
      @required this.collectionItemModel,
      this.collectionModel})
      : assert(collectionItemModel != null);

  @override
  State<StatefulWidget> createState() {
    return _EditCollectionItemPageState();
  }
}

class _EditCollectionItemPageState extends State<EditCollectionItemPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'number': '',
    'quantity': 1,
    'isFav': false,
    'collectionId': null
  };

  @override
  void initState() {
    _formData['collectionId'] = widget.collectionId;
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    int collectionId = _formData['collectionId'];
    widget.collectionItemModel.addCollectionItem(
        collectionId,
        CollectionItem(
          collectionId: collectionId,
          isFav: _formData['isFav'],
          number: _formData['number'],
          quantity: _formData['quantity'],
        ));

    // if (widget.collectionId == null) {
    //   print('/collection/$collectionId');
    //   Application.router.navigateTo(context, '/collection/${collectionId - 1}',
    //       replace: true);
    // } else
    Application.router.pop(context);
  }

  Widget _buildNumberTextField() {
    return TextFormField(
      initialValue: _formData['number'].toString(),
      decoration: InputDecoration(
        labelText: 'Nº do item',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Informe valor válido.';
        }
      },
      onSaved: (String value) {
        _formData['number'] = value;
      },
    );
  }

  Widget _buildQuantityTextField() {
    return TextFormField(
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

  buildCollectionField() {
    return TextFormField(
      initialValue: widget.collectionId.toString(),
      decoration: InputDecoration(
        labelText: 'Coleção',
      ),
      enabled: widget.collectionId == null,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty || int.parse(value) <= 0) {
          return 'Coleção dever ser maior ou igual a 1.';
        }
      },
      onSaved: (String value) {
        _formData['collectionId'] = int.parse(value);
      },
    );
  }

  List<Widget> _buildFields() {
    return [
      buildCollectionField(),
      SizedBox(
        height: 10.0,
      ),
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
      RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text('Salvar'),
        onPressed: _submitForm,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo item'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: _buildFields(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
