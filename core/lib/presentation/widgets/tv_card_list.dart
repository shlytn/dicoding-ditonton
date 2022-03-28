import 'package:core/core.dart';

import '../../presentation/pages/tv_detail_page.dart';
import '../../presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';

class TvCard extends StatelessWidget {
  final Tv tv;

  TvCard(this.tv);

  @override
  Widget build(BuildContext context) {
    return CardList(
      title: tv.name,
      overview: tv.overview,
      posterPath: tv.posterPath,
      onTap: () {
        Navigator.pushNamed(
          context,
          TvDetailPage.ROUTE_NAME,
          arguments: tv.id,
        );
      },
    );
  }
}
