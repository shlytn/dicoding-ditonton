// coverage:ignore-file

import 'package:core/core.dart';

import '../../presentation/pages/movie_detail_page.dart';
import '../../presentation/widgets/horizontal_card_list.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return HorizontalCardList(
            posterPath: movie.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                MovieDetailPage.ROUTE_NAME,
                arguments: movie.id,
              );
            },
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
