import 'package:core/core.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');

  final tGenre = Genre(id: 1, name: 'name');

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should return a JSON map containing proper data', () {
    final expectedJsonMap = {
      "id": 1,
      "name": "name",
    };

    final result = tGenreModel.toJson();
    expect(result, expectedJsonMap);
  });
}
