import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail id) {
    return repository.removeWatchlist(id);
  }
}
