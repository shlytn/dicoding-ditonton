import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/watchlist.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchlistTvStatus getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetailCubit({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailState.init());

  Future<void> get(int id) async {
    emit(state.copyWith(tvDetailState: RequestState.Loading));

    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          tvDetailState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          tvRecommendationsState: RequestState.Loading,
          tvDetail: data,
          tvDetailState: RequestState.Loaded,
        ));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              tvRecommendationsState: RequestState.Error,
              message: failure.message,
            ));
          },
          (data) {
            emit(state.copyWith(
              tvRecommendations: data,
              tvRecommendationsState: RequestState.Loaded,
            ));
          },
        );
      },
    );
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (success) async {
        emit(state.copyWith(watchlistMessage: watchlistAddSuccessMessage));
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (success) async {
        emit(state.copyWith(watchlistMessage: watchlistRemoveSuccessMessage));
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
