import 'package:flutter/material.dart';
import '../../helpers/navigator.dart';
import '../collections/collections.dart';
import '../../data.dart';

class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Logar'),
            onPressed: () => NavigatorHelpers.push(context, CollectionsPage(DataHelpers.tempData), replace: true),
          ),
        ),
      ),
    );
  }
}