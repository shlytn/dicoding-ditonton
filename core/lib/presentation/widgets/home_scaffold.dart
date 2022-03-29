// coverage:ignore-file

import 'package:core/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:search/search.dart';

class HomeScaffold extends StatelessWidget {
  final Widget body;
  final String route;

  HomeScaffold({required this.body, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        route: route,
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: body,
    );
  }
}
