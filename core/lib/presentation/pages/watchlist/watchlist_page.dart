import '../../pages/watchlist/watchlist_movies_page.dart';
import '../../pages/watchlist/watchlist_tv_page.dart';
import '../../widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  List<String> dropdownItems = ['Tv Series', 'Movie'];
  String? value = 'Tv Series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownWidget(
              value: value,
              items: dropdownItems,
              onChanged: (value) => setState(() {
                this.value = value;
              }),
            ),
            Expanded(
              child: value == dropdownItems[0]
                  ? WatchlistTvsPage()
                  : WatchlistMoviesPage(),
            ),
          ],
        ),
      ),
    );
  }
}
