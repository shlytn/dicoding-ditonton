part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MovieDetailState({
    required this.movieDetail,
    required this.movieDetailState,
    required this.movieRecommendations,
    required this.movieRecommendationsState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationsState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory MovieDetailState.init() => MovieDetailState(
        movieDetail: null,
        movieDetailState: RequestState.Empty,
        movieRecommendations: [],
        movieRecommendationsState: RequestState.Empty,
        message: '',
        watchlistMessage: '',
        isAddedToWatchlist: false,
      );

  @override
  List<Object?> get props => [
        movieDetail,
        movieDetailState,
        movieRecommendations,
        movieRecommendationsState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}

// class MovieDetailEmpty extends MovieDetailState {}
//
// class MovieDetailLoading extends MovieDetailState {}
//
// class MovieDetailError extends MovieDetailState {
//   final String message;
//
//   MovieDetailError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class MovieDetailLoaded extends MovieDetailState {
//   final MovieDetail result;
//
//   MovieDetailLoaded(this.result);
//
//   @override
//   List<Object> get props => [result];
// }
//
// class MovieRecommendationEmpty extends MovieDetailState {}
//
// class MovieRecommendationLoading extends MovieDetailState {}
//
// class MovieRecommendationError extends MovieDetailState {
//   final String message;
//
//   MovieRecommendationError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class MovieRecommendationLoaded extends MovieDetailState {
//   final List<Movie> result;
//
//   MovieRecommendationLoaded(this.result);
//
//   @override
//   List<Object> get props => [result];
// }
//
// class MovieWatchlistState extends MovieDetailState {
//   final String message;
//
//   MovieWatchlistState(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class MovieWatchlistStatus extends MovieDetailState {
//   final bool isAdded;
//
//   MovieWatchlistStatus(this.isAdded);
//
//   @override
//   List<Object> get props => [isAdded];
// }}
