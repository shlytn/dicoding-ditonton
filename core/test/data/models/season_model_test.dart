import 'package:core/core.dart';
import 'package:core/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 12,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tSeason = Season(
    airDate: 'airDate',
    episodeCount: 12,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
