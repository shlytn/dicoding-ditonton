import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SeasonCard extends StatelessWidget {
  final Season season;

  SeasonCard(this.season);

  @override
  Widget build(BuildContext context) {
    String year = season.airDate?.substring(0, 4) ?? '-';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 100.0,
              height: 70.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                season.name,
                style: kSubtitle,
              ),
              Text('${season.episodeCount} episodes'),
              SizedBox(
                height: 4.0,
              ),
              Text(year),
            ],
          )
        ]),
      ),
    );
  }
}