import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/cubit/watchlist_movie_cubit.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistMovieCubit>().get());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieCubit>().get();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
        builder: (context, state) {
      if (state is WatchlistMovieLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is WatchlistMovieHasData) {
        final result = state.result;
        return ListView.builder(
          itemBuilder: (context, index) {
            final movie = result[index];
            return MovieCard(movie);
          },
          itemCount: result.length,
        );
      } else if (state is WatchlistMovieError) {
        return Center(
          key: Key('error_message'),
          child: Text(state.message),
        );
      } else {
        return Container();
      }
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
