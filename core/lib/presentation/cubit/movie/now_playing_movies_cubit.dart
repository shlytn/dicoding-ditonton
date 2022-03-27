import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesCubit(this._getNowPlayingMovies) : super(NowPlayingMoviesEmpty());

  Future<void> get() async {
    emit(NowPlayingMoviesLoading());

    final result = await _getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (data) {
        emit(NowPlayingMoviesLoaded(data));
      },
    );
  }
}
