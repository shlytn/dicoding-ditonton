part of 'top_rated_tvs_cubit.dart';

abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class TopRatedTvsEmpty extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState {}

class TopRatedTvsError extends TopRatedTvsState {
  final String message;

  TopRatedTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvsLoaded extends TopRatedTvsState {
  final List<Tv> result;

  TopRatedTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}
