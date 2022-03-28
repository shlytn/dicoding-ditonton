import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_air_tvs_cubit_test.mocks.dart';

@GenerateMocks([GetOnAirTvs])
void main() {
  late MockGetOnAirTvs mockGetOnAirTvs;
  late OnAirTvsCubit cubit;

  setUp(() {
    mockGetOnAirTvs = MockGetOnAirTvs();
    cubit = OnAirTvsCubit(mockGetOnAirTvs);
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  test('initial state should be empty', () {
    expect(cubit.state, OnAirTvsEmpty());
  });

  blocTest<OnAirTvsCubit, OnAirTvsState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetOnAirTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return cubit;
    },
    act: (cubit) => cubit.get(),
    expect: () => [
      OnAirTvsLoading(),
      OnAirTvsLoaded(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTvs.execute());
    },
  );

  blocTest<OnAirTvsCubit, OnAirTvsState>(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetOnAirTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return cubit;
    },
    act: (cubit) => cubit.get(),
    expect: () => [
      OnAirTvsLoading(),
      OnAirTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTvs.execute());
    },
  );
}
