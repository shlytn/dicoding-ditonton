import 'package:about/about.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:watchlist/watchlist.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String route;

  AppDrawer({required this.route});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.live_tv),
            title: Text('TV Series'),
            selected: route == HomeTvPage.ROUTE_NAME,
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeTvPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            selected: route == HomeMoviePage.ROUTE_NAME,
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
