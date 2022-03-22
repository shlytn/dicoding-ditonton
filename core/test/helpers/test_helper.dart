import '../../lib/data/datasources/db/database_helper.dart';
import '../../lib/data/datasources/db/database_helper_tv.dart';
import '../../lib/data/datasources/movie_local_data_source.dart';
import '../../lib/data/datasources/movie_remote_data_source.dart';
import '../../lib/data/datasources/tv_local_data_source.dart';
import '../../lib/data/datasources/tv_remote_data_source.dart';
import '../../lib/domain/repositories/movie_repository.dart';
import '../../lib/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelperTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
