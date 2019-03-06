import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colecao_bolso_app/application/shared/shared.dart';

import '../bloc/search/exporter.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import '../collection_model.dart';
import '../collections_service.dart';

class CollectionSearchPage extends StatefulWidget {
  @override
  _CollectionSearchPageState createState() => _CollectionSearchPageState();
}

class _CollectionSearchPageState extends State<CollectionSearchPage> {
  CollectionsSearchBloc _collectionsSearchBloc;

  void initState() {
    _collectionsSearchBloc =
        CollectionsSearchBloc(CollectionsService.of(context));
    super.initState();
  }

  @override
  void dispose() {
    _collectionsSearchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar coleção'),
      ),
      body: Column(
        children: <Widget>[
          _SearchBar(bloc: _collectionsSearchBloc),
          _SearchBody(bloc: _collectionsSearchBloc)
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final CollectionsSearchBloc bloc;

  const _SearchBar({Key key, @required this.bloc}) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        if (text.length >= 3) {
          print('pesquisar');
          widget.bloc.dispatch(
            TextChangedEvent(text),
          );
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: GestureDetector(
          child: Icon(Icons.clear),
          onTap: _onClearTapped,
        ),
        border: InputBorder.none,
        hintText: 'Insira pelo menos 3 caracteres...',
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    CollectionsSearchBloc.of(context).dispatch(TextChangedEvent(''));
  }
}

class _SearchBody extends StatelessWidget {
  final CollectionsSearchBloc bloc;

  const _SearchBody({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: bloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is SearchStateEmpty) {
          return Text('Please enter a term to begin');
        }
        if (state is BlocLoadingIndicatorState) {
          return CircularProgressIndicator();
        }
        if (state is BlocErrorState) {
          return Text(state.error);
        }
        if (state is SearchStateSuccessState) {
          return state.data.isEmpty
              ? Empty(
                  text: Text('Não foi encontrado nenhum parceiro'),
                )
              : Expanded(child: _SearchResults(items: state.data));
        }

        return Container();
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<Collection> items;

  const _SearchResults({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  final Collection item;

  const _SearchResultItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('${item.name}'),
          leading: Icon(
            item.isFav ? Icons.favorite : Icons.favorite_border,
            color: item.isFav ? Colors.red : null,
          ),
          onTap: () {
            Navigator.pop(context, item.id);
          },
        ),
        Divider()
      ],
    );
  }
}
