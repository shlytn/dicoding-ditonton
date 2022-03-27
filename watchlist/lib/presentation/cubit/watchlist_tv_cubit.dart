import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tvs.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvCubit extends Cubit<WatchlistTvState> {
  final GetWatchlistTvs _getWatchlistTvs;

  WatchlistTvCubit(this._getWatchlistTvs) : super(WatchlistTvEmpty());

  Future<void> get() async {
    emit(WatchlistTvLoading());

    final result = await _getWatchlistTvs.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvError(failure.message));
      },
      (data) {
        emit(WatchlistTvHasData(data));
      },
    );
  }
}
