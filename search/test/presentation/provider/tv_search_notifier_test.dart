import 'package:dartz/dartz.dart';
import '../../../../core/lib/utils/failure.dart';
import '../../../../core/lib/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import '../../../lib/domain/usecases/search_tvs.dart';
import '../../../lib/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTvs mockSearchTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvs = MockSearchTvs();
    provider = TvSearchNotifier(searchTvs: mockSearchTvs)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvModel = Tv(
    backdropPath: '/q8eejQcg1bAqImEV8jh8RtBD4uH.jpg',
    firstAirDate: '2021-11-06',
    genreIds: [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    originalName: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    popularity: 218.007,
    posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    voteAverage: 9.1,
    voteCount: 1869,
  );

  final tTvList = <Tv>[tTvModel];
  final tQuery = 'spiderman';

  group('search Tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
