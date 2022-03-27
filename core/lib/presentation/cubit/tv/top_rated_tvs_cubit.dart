import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tvs_state.dart';

class TopRatedTvsCubit extends Cubit<TopRatedTvsState> {
  final GetTopRatedTvs _getTopRatedTvs;

  TopRatedTvsCubit(this._getTopRatedTvs) : super(TopRatedTvsEmpty());

  Future<void> get() async {
    emit(TopRatedTvsLoading());

    final result = await _getTopRatedTvs.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvsError(failure.message));
      },
      (data) {
        emit(TopRatedTvsLoaded(data));
      },
    );
  }
}
