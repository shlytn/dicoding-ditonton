part of 'popular_tvs_cubit.dart';

abstract class PopularTvsState extends Equatable {
  const PopularTvsState();

  @override
  List<Object> get props => [];
}

class PopularTvsEmpty extends PopularTvsState {}

class PopularTvsLoading extends PopularTvsState {}

class PopularTvsError extends PopularTvsState {
  final String message;

  PopularTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvsLoaded extends PopularTvsState {
  final List<Tv> result;

  PopularTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}
