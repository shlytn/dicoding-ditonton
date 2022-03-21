import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_tv_page.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistTvNotifier, WatchlistMovieNotifier])
void main() {
  late MockWatchlistTvNotifier mockTvNotifier;
  late MockWatchlistMovieNotifier mockMovieNotifier;

  setUp(() {
    mockTvNotifier = MockWatchlistTvNotifier();
    mockMovieNotifier = MockWatchlistMovieNotifier();
  });

  group('Watchlist Tv', () {
    Widget _makeTestableWidget(Widget body) {
      return ChangeNotifierProvider<WatchlistTvNotifier>.value(
        value: mockTvNotifier,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockTvNotifier.watchlistState).thenReturn(RequestState.Loading);

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockTvNotifier.watchlistState).thenReturn(RequestState.Loaded);
      when(mockTvNotifier.watchlistTvs).thenReturn(<Tv>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTvNotifier.watchlistState).thenReturn(RequestState.Error);
      when(mockTvNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Watchlist Movie', () {
    Widget _makeTestableWidget(Widget body) {
      return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
        value: mockMovieNotifier,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loading);

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loaded);
      when(mockMovieNotifier.watchlistMovies).thenReturn(<Movie>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
