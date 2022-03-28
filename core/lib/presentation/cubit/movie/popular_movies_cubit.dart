import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesCubit(this._getPopularMovies) : super(PopularMoviesEmpty());

  Future<void> get() async {
    emit(PopularMoviesLoading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (data) {
        emit(PopularMoviesLoaded(data));
      },
    );
  }
}
