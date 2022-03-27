import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieCubit(this._getWatchlistMovies) : super(WatchlistMovieEmpty());

  Future<void> get() async {
    emit(WatchlistMovieLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistMovieError(failure.message));
      },
      (data) {
        emit(WatchlistMovieHasData(data));
      },
    );
  }
}
