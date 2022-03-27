part of 'tv_detail_cubit.dart';

class TvDetailState extends Equatable {
  final TvDetail? tvDetail;
  final RequestState tvDetailState;
  final List<Tv> tvRecommendations;
  final RequestState tvRecommendationsState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TvDetailState({
    required this.tvDetail,
    required this.tvDetailState,
    required this.tvRecommendations,
    required this.tvRecommendationsState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  TvDetailState copyWith({
    TvDetail? tvDetail,
    RequestState? tvDetailState,
    List<Tv>? tvRecommendations,
    RequestState? tvRecommendationsState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TvDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvRecommendationsState:
          tvRecommendationsState ?? this.tvRecommendationsState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory TvDetailState.init() => TvDetailState(
        tvDetail: null,
        tvDetailState: RequestState.Empty,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Empty,
        message: '',
        watchlistMessage: '',
        isAddedToWatchlist: false,
      );

  @override
  List<Object?> get props => [
        tvDetail,
        tvDetailState,
        tvRecommendations,
        tvRecommendationsState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
