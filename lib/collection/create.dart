import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tags/input_tags.dart';

import 'collection_item_model.dart';
import 'create_result_model.dart';

import '../widgets/forms-input/image.dart';
import '../common/common.dart';

class EditCollectionItemPage extends StatefulWidget {
  /// É possível criamos um item para uma determinada coleção, basta informar o ID da mesma
  final int collectionId;

  /// Quando collectionId for nulo, deve ser passado valor
  // final CollectionModel collectionModel;

  final Object collectionItemModel;

  EditCollectionItemPage(
      {this.collectionId, @required this.collectionItemModel})
      : assert(collectionItemModel != null);

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
  List<String> _tags = [];

  @override
  void initState() {
    _selectedCollectionId = widget.collectionId;
    // widget.collectionModel.fetch();
    _tags = [];
    super.initState();
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
    var entity = CollectionItem(
        collectionId: _selectedCollectionId,
        isFav: _formData['isFav'],
        number: _formData['number'],
        quantity: _formData['quantity'],
        tags: _tags);

    // widget.collectionItemModel.addCollectionItem(_selectedCollectionId, entity);

    var result = CreateItemResult(_selectedCollectionId, entity.id);
    Navigator.pop(context, result);
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
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, Model model) {
        return null;
        //   if (model.collections.length > 0 && !model.isLoading) {
        //     if (_selectedCollectionId == null) {
        //       _selectedCollectionId = model.collections[0].id;
        //     }

        //     return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        //       Text(
        //         'Coleção',
        //         style: TextStyle(fontSize: 18.0),
        //       ),
        //       SizedBox(
        //         width: 25.0,
        //       ),
        //       DropdownButton(
        //           value: _selectedCollectionId,
        //           items: model.collections
        //               .map((item) => DropdownMenuItem<int>(
        //                   value: item.id, child: Text(item.name)))
        //               .toList(),
        //           onChanged: (int value) {
        //             setState(() {
        //               _selectedCollectionId = value;
        //               print(_selectedCollectionId);
        //             });
        //           })
        //     ]);
        //   } else if (model.collections.length == 0 && !model.isLoading) {
        //     return Center(
        //         child: Text(
        //       'É necessário criar uma coleção para adicionar item',
        //       style: TextStyle(fontSize: 20.0),
        //     ));
        //   } else if (model.isLoading) {
        //     return Center(child: CircularProgressIndicator());
        //   }
      },
    );
  }

  Widget _buildTagsInput() {
    return InputTags(
      tags: [],
      placeholder: 'Adicione tagas a seu item',
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

  List<Widget> _buildFields(BuildContext context) {
    return [
      buildCollectionField(),
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
      RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text('Salvar'),
        onPressed: () => _submitForm(context),
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
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: _buildFields(context),
          ),
        ),
      ),
    );
  }
}
