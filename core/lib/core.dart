library core;

// utils
export 'styles/colors.dart';
export 'styles/text_styles.dart';
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';

// entities
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'domain/entities/tv.dart';
export 'domain/entities/tv_detail.dart';

// repository
export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_repository.dart';

// usecases
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';

export 'domain/usecases/get_tv_detail.dart';
export 'domain/usecases/get_tv_recommendations.dart';
export 'domain/usecases/get_on_air_tvs.dart';
export 'domain/usecases/get_popular_tvs.dart';
export 'domain/usecases/get_top_rated_tvs.dart';