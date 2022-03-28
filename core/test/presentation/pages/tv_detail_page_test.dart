import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailCubit extends MockCubit<TvDetailState>
    implements TvDetailCubit {}

class TvDetailStateFake extends Fake implements TvDetailState {}

void main() {
  late MockTvDetailCubit mockCubit;
  late TvDetailState initState;

  setUpAll(() {
    registerFallbackValue(TvDetailStateFake());
  });

  setUp(() {
    mockCubit = MockTvDetailCubit();
    initState = TvDetailState.init();
  });

  void init() {
    when(() => mockCubit.get(any())).thenAnswer((_) => Future.value());
    when(() => mockCubit.loadWatchlistStatus(any()))
        .thenAnswer((_) => Future.value());
  }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      tvDetailState: RequestState.Loaded,
      tvDetail: testTvDetail,
      tvRecommendationsState: RequestState.Loaded,
      tvRecommendations: [],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv is added to watchlist',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      tvDetailState: RequestState.Loaded,
      tvDetail: testTvDetail,
      tvRecommendationsState: RequestState.Loaded,
      tvRecommendations: [],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    init();
    when(() => mockCubit.addWatchlist(testTvDetail))
        .thenAnswer((_) => Future.value());
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      tvDetailState: RequestState.Loaded,
      tvDetail: testTvDetail,
      tvRecommendationsState: RequestState.Loaded,
      tvRecommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: 'Added to Watchlist',
    ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

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
    when(() => mockCubit.addWatchlist(testTvDetail))
        .thenAnswer((_) => Future.value());
    when(() => mockCubit.state).thenReturn(initState.copyWith(
      tvDetailState: RequestState.Loaded,
      tvDetail: testTvDetail,
      tvRecommendationsState: RequestState.Loaded,
      tvRecommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: 'Failed',
    ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
