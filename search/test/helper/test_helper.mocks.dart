// Mocks generated by Mockito 5.1.0 from annotations
// in search/test/helper/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i8;
import 'dart:typed_data' as _i9;

import 'package:core/core.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/src/base_request.dart' as _i10;
import 'package:http/src/client.dart' as _i7;
import 'package:http/src/response.dart' as _i3;
import 'package:http/src/streamed_response.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeResponse_1 extends _i1.Fake implements _i3.Response {}

class _FakeStreamedResponse_2 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i5.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i5.Movie>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i5.Movie>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i5.Movie>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, _i5.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, _i5.MovieDetail>>.value(
              _FakeEither_0<_i5.Failure, _i5.MovieDetail>())) as _i6
          .Future<_i2.Either<_i5.Failure, _i5.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i5.Movie>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i5.Movie>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(
          _i5.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i6.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
          _i5.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i6.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i5.Movie>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i5.Movie>>>);
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i5.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>> getOnAirTvs() =>
      (super.noSuchMethod(Invocation.method(#getOnAirTvs, []),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i5.Tv>>()))
          as _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>> getPopularTvs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvs, []),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i5.Tv>>()))
          as _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>> getTopRatedTvs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvs, []),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i5.Tv>>()))
          as _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, _i5.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
              returnValue: Future<_i2.Either<_i5.Failure, _i5.TvDetail>>.value(
                  _FakeEither_0<_i5.Failure, _i5.TvDetail>()))
          as _i6.Future<_i2.Either<_i5.Failure, _i5.TvDetail>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i5.Tv>>()))
          as _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>> searchTvs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvs, [query]),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i5.Tv>>()))
          as _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(_i5.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i6.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
          _i5.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i6.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i5.Tv>>()))
          as _i6.Future<_i2.Either<_i5.Failure, List<_i5.Tv>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i7.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i8.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i8.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i8.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i8.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i9.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i9.Uint8List>.value(_i9.Uint8List(0)))
          as _i6.Future<_i9.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i10.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_2()))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
