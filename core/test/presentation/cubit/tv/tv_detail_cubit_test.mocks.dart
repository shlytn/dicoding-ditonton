// Mocks generated by Mockito 5.1.0 from annotations
// in core/test/presentation/cubit/tv/tv_detail_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/core.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:watchlist/domain/usecases/get_watchlist_tv_status.dart' as _i5;
import 'package:watchlist/domain/usecases/remove_watchlist_tv.dart' as _i7;
import 'package:watchlist/domain/usecases/save_watchlist_tv.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvRepository_0 extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTvDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvDetail extends _i1.Mock implements _i2.GetTvDetail {
  MockGetTvDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i2.Failure, _i2.TvDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i2.Failure, _i2.TvDetail>>.value(
                  _FakeEither_1<_i2.Failure, _i2.TvDetail>()))
          as _i4.Future<_i3.Either<_i2.Failure, _i2.TvDetail>>);
}

/// A class which mocks [GetTvRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvRecommendations extends _i1.Mock
    implements _i2.GetTvRecommendations {
  MockGetTvRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i2.Failure, List<_i2.Tv>>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i2.Failure, List<_i2.Tv>>>.value(
                  _FakeEither_1<_i2.Failure, List<_i2.Tv>>()))
          as _i4.Future<_i3.Either<_i2.Failure, List<_i2.Tv>>>);
}

/// A class which mocks [GetWatchlistTvStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvStatus extends _i1.Mock
    implements _i5.GetWatchlistTvStatus {
  MockGetWatchlistTvStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i4.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}

/// A class which mocks [SaveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTv extends _i1.Mock implements _i6.SaveWatchlistTv {
  MockSaveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i2.Failure, String>> execute(_i2.TvDetail? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i2.Failure, String>>.value(
                  _FakeEither_1<_i2.Failure, String>()))
          as _i4.Future<_i3.Either<_i2.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTv extends _i1.Mock implements _i7.RemoveWatchlistTv {
  MockRemoveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i2.Failure, String>> execute(_i2.TvDetail? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i2.Failure, String>>.value(
                  _FakeEither_1<_i2.Failure, String>()))
          as _i4.Future<_i3.Either<_i2.Failure, String>>);
}
