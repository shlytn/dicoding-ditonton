import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/pages/popular_movies_page.dart';
import '../../presentation/pages/top_rated_movies_page.dart';
import '../../presentation/provider/movie_list_notifier.dart';
import '../../presentation/widgets/home_scaffold.dart';
import '../../presentation/widgets/movie_list.dart';
import '../../presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit/movie/now_playing_movies_cubit.dart';
import '../cubit/movie/popular_movies_cubit.dart';
import '../cubit/movie/top_rated_movies_cubit.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesCubit>().get();
      context.read<PopularMoviesCubit>().get();
      context.read<TopRatedMoviesCubit>().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      route: HomeMoviePage.ROUTE_NAME,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              _loadNowPlayingMovieList(),
              SubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              _loadPopularMovieList(),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              _loadTopRatedMovieList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadNowPlayingMovieList() {
    return BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
        builder: (context, state) {
      if (state is NowPlayingMoviesLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NowPlayingMoviesLoaded) {
        return MovieList(state.result);
      } else if (state is NowPlayingMoviesError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    });
  }

  Widget _loadPopularMovieList() {
    return BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
      if (state is PopularMoviesLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PopularMoviesLoaded) {
        return MovieList(state.result);
      } else if (state is PopularMoviesError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    });
  }

  Widget _loadTopRatedMovieList() {
    return BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
        builder: (context, state) {
      if (state is TopRatedMoviesLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TopRatedMoviesLoaded) {
        return MovieList(state.result);
      } else if (state is TopRatedMoviesError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    });
  }
}
