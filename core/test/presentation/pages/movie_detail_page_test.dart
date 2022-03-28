import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailCubit extends MockCubit<MovieDetailState>
    implements MovieDetailCubit {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

void main() {
  late MockMovieDetailCubit mockCubit;
  late MovieDetailState initState;

  setUpAll(() {
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockCubit = MockMovieDetailCubit();
    initState = MovieDetailState.init();
  });

  void init() {
    when(() => mockCubit.get(any())).thenAnswer((_) => Future.value());
    when(() => mockCubit.loadWatchlistStatus(any()))
        .thenAnswer((_) => Future.value());
  }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      movieRecommendationsState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      movieRecommendationsState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.addWatchlist(testMovieDetail))
        .thenAnswer((_) => Future.value());
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      movieRecommendationsState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: 'Added to Watchlist',
    ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.addWatchlist(testMovieDetail))
        .thenAnswer((_) => Future.value());
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      movieRecommendationsState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: 'Failed',
    ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
