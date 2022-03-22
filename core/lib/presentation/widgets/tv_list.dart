import '../../domain/entities/tv.dart';
import '../../presentation/pages/tv_detail_page.dart';
import '../../presentation/widgets/horizontal_card_list.dart';
import 'package:flutter/material.dart';

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return HorizontalCardList(
            posterPath: tv.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                TvDetailPage.ROUTE_NAME,
                arguments: tv.id,
              );
            },
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
