import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_air_tvs.dart';
import 'package:flutter/foundation.dart';

class OnAirTvsNotifier extends ChangeNotifier {
  final GetOnAirTvs getOnAirTvs;

  OnAirTvsNotifier({required this.getOnAirTvs});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvs.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
