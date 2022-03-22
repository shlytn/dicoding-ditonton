import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

class SaveWatchlistTv {
  final TvRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail id) {
    return repository.saveWatchlist(id);
  }
}
