// coverage:ignore-file

import 'package:core/core.dart';

import '../../presentation/pages/movie_detail_page.dart';
import '../../presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return CardList(
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieDetailPage.ROUTE_NAME,
          arguments: movie.id,
        );
      },
    );
  }
}
