import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main(){
  late TvSearchBloc searchBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchBloc = TvSearchBloc(mockSearchTvs);
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
  final tQuery = 'arcane';

  test('initial state should be empty', () {
    expect(searchBloc.state, TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      TvSearchLoading(),
      TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}