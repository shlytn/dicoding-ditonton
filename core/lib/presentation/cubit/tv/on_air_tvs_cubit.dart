import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'on_air_tvs_state.dart';

class OnAirTvsCubit extends Cubit<OnAirTvsState> {
  final GetOnAirTvs _getOnAirTvs;
  
  OnAirTvsCubit(this._getOnAirTvs) : super(OnAirTvsEmpty());

  Future<void> get() async {
    emit(OnAirTvsLoading());

    final result = await _getOnAirTvs.execute();

    result.fold(
          (failure) {
        emit(OnAirTvsError(failure.message));
      },
          (data) {
        emit(OnAirTvsLoaded(data));
      },
    );
  }
}
