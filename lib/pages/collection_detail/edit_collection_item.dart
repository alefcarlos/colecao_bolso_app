import 'package:flutter/material.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:scoped_model/scoped_model.dart';

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
      @required this.collectionModel})
      : assert(collectionItemModel != null),
        assert(collectionModel != null);

  @override
  State<StatefulWidget> createState() {
    return _EditCollectionItemPageState();
  }
}

class _EditCollectionItemPageState extends State<EditCollectionItemPage> {
  int _selectedCollectionId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'number': '',
    'quantity': 1,
    'isFav': false
  };

  @override
  void initState() {
    _selectedCollectionId = widget.collectionId;
    widget.collectionModel.fetch();
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.collectionItemModel.addCollectionItem(
        _selectedCollectionId,
        CollectionItem(
          collectionId: _selectedCollectionId,
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
    // return TextFormField(
    //   initialValue: widget.collectionId.toString(),
    //   decoration: InputDecoration(
    //     labelText: 'Coleção',
    //   ),
    //   enabled: widget.collectionId == null,
    //   keyboardType: TextInputType.number,
    //   validator: (String value) {
    //     if (value.isEmpty || int.parse(value) <= 0) {
    //       return 'Coleção dever ser maior ou igual a 1.';
    //     }
    //   },
    //   onSaved: (String value) {
    //     _selectedCollectionId = int.parse(value);
    //   },
    // );
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, CollectionModel model) {
        if (model.collections.length > 0 && !model.isLoading) {
          // return FlutterSearchPanel(
          //     padding: EdgeInsets.all(10.0),
          //     selected: widget.collectionId != null
          //         ? model.collections
          //             .firstWhere((item) => item.id == widget.collectionId)
          //             .name
          //         : null,
          //     title: 'Selcionar coleção',
          //     data: model.collections.map((item) => item.name).toList(),
          //     icon: new Icon(Icons.check_circle, color: Colors.white),
          //     color: Theme.of(context).primaryColor,
          //     textStyle: new TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16.0),
          //     onChanged: (value) {
          //       print(value);
          //     });

          if (_selectedCollectionId == null) {
            _selectedCollectionId = model.collections[0].id;
          }

          return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
              'Coleção',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 10.0,
            ),
            DropdownButton(
                value: _selectedCollectionId,
                items: model.collections
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: (int value) {
                  setState(() {
                    _selectedCollectionId = value;
                    print(_selectedCollectionId);
                  });
                })
          ]);
        } else if (model.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
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
    );
  }
}
