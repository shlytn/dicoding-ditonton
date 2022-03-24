import 'package:core/core.dart';
import 'package:core/presentation/widgets/dropdown_widget.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> dropdownItems = ['Tv Series', 'Movie'];
  String? value = 'Tv Series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<MovieSearchBloc>().add(OnQueryChanged(query));
                context.read<TvSearchBloc>().add(OnTvQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            SizedBox(
              height: 8,
            ),
            DropdownWidget(
              value: value,
              items: dropdownItems,
              onChanged: (value) => setState(() {
                this.value = value;
              }),
            ),
            value == dropdownItems[0] ? _buildTvSearch() : _buildMovieSearch(),
          ],
        ),
      ),
    );
  }

  Widget _buildTvSearch() {
    return BlocBuilder<TvSearchBloc, TvSearchState>(
      builder: (context, state) {
        if (state is TvSearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tv = result[index];
                return TvCard(tv);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is TvSearchError) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget _buildMovieSearch() {
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
