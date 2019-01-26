import 'package:flutter/material.dart';
import '../../config/application.dart';
import '../../entities/collectionEntity.dart';

class CreateCollectionPage extends StatefulWidget {
  final Function createCollection;

  CreateCollectionPage(this.createCollection);

  _CreateCollectionPageState createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  String _name = '';
  int _totalItems = 0;
  bool _isFavorite = false;

  _addCollection() {
    var entity = CollectionEntity.create(_name,
        isFav: _isFavorite, itemCount: _totalItems);

    widget.createCollection(entity);
    Application.router.pop(context);
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
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: _addCollection,
                  child: Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
