import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailCubit cubit;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTvStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    cubit = TvDetailCubit(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final stateInit = TvDetailState.init();

  final tId = 1;

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

  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit tv detail and recommendation [Empty, Loading, Loaded] when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return cubit;
      },
      act: (cubit) => cubit.get(tId),
      expect: () => [
        stateInit.copyWith(
          tvDetailState: RequestState.Loading,
          tvDetail: null,
          tvRecommendationsState: RequestState.Empty,
          tvRecommendations: [],
        ),
        stateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationsState: RequestState.Loading,
          tvRecommendations: [],
        ),
        stateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationsState: RequestState.Loaded,
          tvRecommendations: tTvs,
        ),
      ],
      verify: (cubit) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit tv detail and recommendation [Empty, Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return cubit;
      },
      act: (cubit) => cubit.get(tId),
      expect: () => [
        stateInit.copyWith(
          tvDetailState: RequestState.Loading,
          tvDetail: null,
          tvRecommendationsState: RequestState.Empty,
          tvRecommendations: [],
          message: '',
        ),
        stateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationsState: RequestState.Loading,
          tvRecommendations: [],
          message: '',
        ),
        stateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationsState: RequestState.Error,
          tvRecommendations: [],
          message: 'Failed',
        ),
      ],
      verify: (cubit) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.loadWatchlistStatus(tId),
      expect: () => [
        stateInit.copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (cubit) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    group('Save Watchlist', () {
      blocTest<TvDetailCubit, TvDetailState>(
        'Should emit save watchlist when function called successfully',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) => cubit.addWatchlist(testTvDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Added to Watchlist',
            isAddedToWatchlist: false,
          ),
          stateInit.copyWith(
            watchlistMessage: 'Added to Watchlist',
            isAddedToWatchlist: true,
          ),
        ],
        verify: (cubit) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        },
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'Should emit watchlist message when add watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.addWatchlist(testTvDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Failed',
            isAddedToWatchlist: false,
          ),
        ],
        verify: (cubit) {
          verify(mockSaveWatchlist.execute(testTvDetail));
        },
      );
    });

    group('Removed Watchlist', () {
      blocTest<TvDetailCubit, TvDetailState>(
        'Should emit remove watchlist when function called successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.removeFromWatchlist(testTvDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Removed from Watchlist',
            isAddedToWatchlist: false,
          ),
        ],
        verify: (cubit) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        },
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'Should emit watchlist message when remove watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.removeFromWatchlist(testTvDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Failed',
            isAddedToWatchlist: false,
          ),
        ],
        verify: (cubit) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        },
      );
    });
  });

  group('On Detail Error', () {
    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit tv detail [Empty, Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return cubit;
      },
      act: (cubit) => cubit.get(tId),
      expect: () => [
        stateInit.copyWith(
          tvDetailState: RequestState.Loading,
          tvDetail: null,
          message: '',
        ),
        stateInit.copyWith(
          tvDetailState: RequestState.Error,
          tvDetail: null,
          message: 'Failed',
        ),
      ],
      verify: (cubit) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });
}
