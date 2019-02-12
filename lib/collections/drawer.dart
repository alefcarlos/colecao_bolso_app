import 'package:flutter/material.dart';
import '../tags/route_handler.dart';
import '../config/app_config.dart';

class CollectionsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            title: Text(
              'Tags mais utilizadas',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            onTap: () => Application.router.navigateTo(context, TagsRoute.tags),
          )
        ],
      ),
    );
  }
}
