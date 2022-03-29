import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tvs.dart';
import 'package:watchlist/presentation/cubit/watchlist_tv_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvCubit cubit;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    cubit = WatchlistTvCubit(mockGetWatchlistTvs);
  });

  test('initial state should be empty', () {
    expect(cubit.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvCubit, WatchlistTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () => () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return cubit;
    }(),
    act: (cubit) => cubit.get(),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData([testWatchlistTv]),
    ],
    verify: (cubit) => verify(mockGetWatchlistTvs.execute()),
  );

  blocTest<WatchlistTvCubit, WatchlistTvState>(
    'should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () => () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return cubit;
    }(),
    act: (cubit) => cubit.get(),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvError("Can't get data"),
    ],
    verify: (cubit) => verify(mockGetWatchlistTvs.execute()),
  );
}
