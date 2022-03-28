import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailCubit cubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final stateInit = MovieDetailState.init();

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'Should emit movie detail and recommendation [Empty, Loading, Loaded] when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return cubit;
      },
      act: (cubit) => cubit.get(tId),
      expect: () => [
        stateInit.copyWith(
          movieDetailState: RequestState.Loading,
          movieDetail: null,
          movieRecommendationsState: RequestState.Empty,
          movieRecommendations: [],
        ),
        stateInit.copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Loading,
          movieRecommendations: [],
        ),
        stateInit.copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Loaded,
          movieRecommendations: tMovies,
        ),
      ],
      verify: (cubit) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'Should emit movie detail and recommendation [Empty, Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return cubit;
      },
      act: (cubit) => cubit.get(tId),
      expect: () => [
        stateInit.copyWith(
          movieDetailState: RequestState.Loading,
          movieDetail: null,
          movieRecommendationsState: RequestState.Empty,
          movieRecommendations: [],
          message: '',
        ),
        stateInit.copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Loading,
          movieRecommendations: [],
          message: '',
        ),
        stateInit.copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Error,
          movieRecommendations: [],
          message: 'Failed',
        ),
      ],
      verify: (cubit) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
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
      blocTest<MovieDetailCubit, MovieDetailState>(
        'Should emit save watchlist when function called successfully',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) => cubit.addWatchlist(testMovieDetail),
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
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        },
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'Should emit watchlist message when add watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.addWatchlist(testMovieDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Failed',
            isAddedToWatchlist: false,
          ),
        ],
        verify: (cubit) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );
    });

    group('Removed Watchlist', () {
      blocTest<MovieDetailCubit, MovieDetailState>(
        'Should emit remove watchlist when function called successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Removed from Watchlist',
            isAddedToWatchlist: false,
          ),
        ],
        verify: (cubit) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        },
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'Should emit watchlist message when remove watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
        expect: () => [
          stateInit.copyWith(
            watchlistMessage: 'Failed',
            isAddedToWatchlist: false,
          ),
        ],
        verify: (cubit) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        },
      );
    });
  });

  group('On Detail Error', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'Should emit movie detail [Empty, Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return cubit;
      },
      act: (cubit) => cubit.get(tId),
      expect: () => [
        stateInit.copyWith(
          movieDetailState: RequestState.Loading,
          movieDetail: null,
          message: '',
        ),
        stateInit.copyWith(
          movieDetailState: RequestState.Error,
          movieDetail: null,
          message: 'Failed',
        ),
      ],
      verify: (cubit) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });
}
