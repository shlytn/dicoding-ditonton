import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_on_air_tvs.dart';
import '../../domain/usecases/get_popular_tvs.dart';
import '../../domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter/foundation.dart';

class TvListNotifier extends ChangeNotifier {
  var _onAirTvs = <Tv>[];
  List<Tv> get onAirTvs => _onAirTvs;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.Empty;
  RequestState get popularTvsState => _popularTvsState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.Empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getOnAirTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  final GetOnAirTvs getOnAirTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  Future<void> fetchOnAirTvs() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvs.execute();
    result.fold((failure) {
      _onAirState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvsData) {
      _onAirState = RequestState.Loaded;
      _onAirTvs = tvsData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.Loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvsState = RequestState.Loaded;
        _topRatedTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
