import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/exporter.dart';
import '../bloc/create/exporter.dart';
import '../../common/loading-indicator.dart';

class CollectionSelector extends StatefulWidget {
  final int selectedId;
  final CreateCollectionItemBloc bloc;
  final Function onChanged;

  const CollectionSelector(
      {@required this.bloc, @required this.onChanged, this.selectedId})
      : assert(bloc != null),
        assert(onChanged != null);

  @override
  _CollectionSelectorState createState() => _CollectionSelectorState();
}

class _CollectionSelectorState extends State<CollectionSelector> {
  CreateCollectionItemBloc get bloc => widget.bloc;
  Function get onChanged => widget.onChanged;
  int selected;

  @override
  void initState() {
    selected = widget.selectedId;
    bloc.dispatch(CollectionFetchAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: widget.bloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is BlocLoadingIndicatorState) {
          return LoadingIndicator();
        }

        if (state is CollectionsLoadedAllState) {
          if (state.data.isEmpty) {
            return Center(
                child: Text(
              'É necessário criar uma coleção para adicionar item',
              style: TextStyle(fontSize: 20.0),
            ));
          }

          var disabled = widget.selectedId != null;
          selected = selected == null ? state.data.first.id : selected;
          var selectedEntity = disabled
              ? state.data.firstWhere((item) => item.id == selected)
              : null;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Coleção',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 25.0,
              ),
              DropdownButton(
                disabledHint: disabled ? Text('${selectedEntity.name}') : null,
                value: selected,
                items: state.data
                    .map((item) => DropdownMenuItem<int>(
                        value: item.id, child: Text(item.name)))
                    .toList(),
                onChanged: disabled
                    ? null
                    : (int value) => {
                          setState(
                            () {
                              selected = value;
                              onChanged(value);
                            },
                          )
                        },
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}
