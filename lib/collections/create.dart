import 'package:flutter/material.dart';
import './collection_model.dart';
import './collection_scoped_model.dart';

class CreateCollectionPage extends StatefulWidget {
  _CreateCollectionPageState createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  String _name = '';
  int _totalItems = 0;
  bool _isFavorite = false;

  _addCollection(Function addCollection) {
    var entity =
        Collection(0, _name, _isFavorite, _totalItems);

    addCollection(entity);
    Navigator.pop(context, entity.id);
  }

  Widget _buildSubmitButton(BuildContext context) {
    var model = CollectionModel.of(context);

    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () => _addCollection(model.addCollection),
      child: Text('Salvar'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Coleção'),
      ),
      body: Container(
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
                _buildSubmitButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
