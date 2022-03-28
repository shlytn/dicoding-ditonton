import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:watchlist/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTvCubit extends MockCubit<WatchlistTvState>
    implements WatchlistTvCubit {}

class WatchlistTvStateFake extends Fake implements WatchlistTvState {}

class MockWatchlistMovieCubit extends MockCubit<WatchlistMovieState>
    implements WatchlistMovieCubit {}

class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}

void main() {
  late MockWatchlistTvCubit mockTvCubit;
  late MockWatchlistMovieCubit mockMovieCubit;

  setUpAll(() {
    registerFallbackValue(WatchlistTvStateFake());
    registerFallbackValue(WatchlistMovieStateFake());
  });

  setUp(() {
    mockTvCubit = MockWatchlistTvCubit();
    mockMovieCubit = MockWatchlistMovieCubit();
  });

  group('Watchlist Tv', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<WatchlistTvCubit>.value(
        value: mockTvCubit,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    void init() {
      when(() => mockTvCubit.get()).thenAnswer((_) => Future.value());
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockTvCubit.state).thenReturn(WatchlistTvLoading());
      init();

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTvCubit.state).thenReturn(WatchlistTvHasData([testWatchlistTv]));
      init();

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTvCubit.state).thenReturn(WatchlistTvError('Error Message'));
      init();

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Watchlist Movie', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<WatchlistMovieCubit>.value(
        value: mockMovieCubit,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    void init() {
      when(() => mockMovieCubit.get()).thenAnswer((_) => Future.value());
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockMovieCubit.state).thenReturn(WatchlistMovieLoading());
      init();

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieCubit.state).thenReturn(WatchlistMovieHasData([]));
      init();

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieCubit.state)
          .thenReturn(WatchlistMovieError('Error message'));
      init();

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
