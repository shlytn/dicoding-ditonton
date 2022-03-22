import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SaveWatchlistTv {
  final TvRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail id) {
    return repository.saveWatchlist(id);
  }
}
