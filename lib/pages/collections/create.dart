import 'package:flutter/material.dart';
import '../../config/application.dart';
import '../../models/collection.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/collection.dart';

class CreateCollectionPage extends StatefulWidget {
  _CreateCollectionPageState createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  String _name = '';
  int _totalItems = 0;
  bool _isFavorite = false;

  _addCollection(Function addCollection) {
    var entity =
        Collection(name: _name, isFav: _isFavorite, itemCount: _totalItems);

    addCollection(entity);
    Application.router.pop(context);
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<CollectionModel>(
      builder: (BuildContext context, Widget child, CollectionModel model) {
        return RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: () => _addCollection(model.addCollection),
          child: Text('Salvar'),
        );
      },
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
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
