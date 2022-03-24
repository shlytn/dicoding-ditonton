import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_tvs.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(TvSearchEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await _searchTvs.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          emit(TvSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 1000)));
  }
}
