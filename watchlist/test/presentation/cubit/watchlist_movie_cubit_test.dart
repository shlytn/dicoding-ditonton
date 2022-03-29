import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/presentation/cubit/watchlist_movie_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieCubit cubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    cubit = WatchlistMovieCubit(mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(cubit.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () => () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return cubit;
    }(),
    act: (cubit) => cubit.get(),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData([testWatchlistMovie]),
    ],
    verify: (cubit) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () => () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return cubit;
    }(),
    act: (cubit) => cubit.get(),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError("Can't get data"),
    ],
    verify: (cubit) => verify(mockGetWatchlistMovies.execute()),
  );
}
