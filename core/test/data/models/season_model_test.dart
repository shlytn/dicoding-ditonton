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

  test('should return a JSON map containing proper data', () {
    final expectedJsonMap = {
      "air_date": "airDate",
      "episode_count": 12,
      "id": 1,
      "name": "name",
      "overview": "overview",
      "poster_path": "posterPath",
      "season_number": 1,
    };

    final result = tSeasonModel.toJson();
    expect(result, expectedJsonMap);
  });
}
