import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/cubit/tv/on_air_tvs_cubit.dart';
import 'package:core/presentation/pages/on_air_tvs_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnAirTvsCubit extends MockCubit<OnAirTvsState>
    implements OnAirTvsCubit {}

class OnAirTvsStateFake extends Fake implements OnAirTvsState {}

void main() {
  late MockOnAirTvsCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(OnAirTvsStateFake());
  });

  setUp(() {
    mockCubit = MockOnAirTvsCubit();
  });

  void init() {
    when(() => mockCubit.get()).thenAnswer((_) => Future.value());
  }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnAirTvsCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(OnAirTvsLoading());
    init();

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(OnAirTvsLoaded([]));
    init();

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(OnAirTvsError('Error message'));
    init();

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnAirTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
