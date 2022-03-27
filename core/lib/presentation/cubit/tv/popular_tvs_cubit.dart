import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'popular_tvs_state.dart';

class PopularTvsCubit extends Cubit<PopularTvsState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvsCubit(this._getPopularTvs) : super(PopularTvsEmpty());

  Future<void> get() async {
    emit(PopularTvsLoading());

    final result = await _getPopularTvs.execute();

    result.fold(
      (failure) {
        emit(PopularTvsError(failure.message));
      },
      (data) {
        emit(PopularTvsLoaded(data));
      },
    );
  }
}
