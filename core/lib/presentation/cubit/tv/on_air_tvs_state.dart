part of 'on_air_tvs_cubit.dart';

abstract class OnAirTvsState extends Equatable {
  const OnAirTvsState();

  @override
  List<Object> get props => [];
}

class OnAirTvsEmpty extends OnAirTvsState {}

class OnAirTvsLoading extends OnAirTvsState {}

class OnAirTvsError extends OnAirTvsState {
  final String message;

  OnAirTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAirTvsLoaded extends OnAirTvsState {
  final List<Tv> result;

  OnAirTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}
