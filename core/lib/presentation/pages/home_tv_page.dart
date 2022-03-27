import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/pages/on_air_tvs_page.dart';
import '../../presentation/pages/popular_tvs_page.dart';
import '../../presentation/pages/top_rated_tvs_page.dart';
import '../../presentation/widgets/home_scaffold.dart';
import '../../presentation/widgets/sub_heading.dart';
import '../../presentation/widgets/tv_list.dart';
import 'package:flutter/material.dart';

import '../cubit/tv/on_air_tvs_cubit.dart';
import '../cubit/tv/popular_tvs_cubit.dart';
import '../cubit/tv/top_rated_tvs_cubit.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnAirTvsCubit>().get();
      context.read<PopularTvsCubit>().get();
      context.read<TopRatedTvsCubit>().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      route: HomeTvPage.ROUTE_NAME,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'Tv Airing',
                onTap: () =>
                    Navigator.pushNamed(context, OnAirTvsPage.ROUTE_NAME),
              ),
              _loadOnAirTvList(),
              SubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
              ),
              _loadPopularTvList(),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
              ),
              _loadTopRatedTvList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadOnAirTvList() {
    return BlocBuilder<OnAirTvsCubit, OnAirTvsState>(builder: (context, state) {
      if (state is OnAirTvsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is OnAirTvsLoaded) {
        return TvList(state.result);
      } else if (state is OnAirTvsError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    });
  }

  Widget _loadPopularTvList() {
    return BlocBuilder<PopularTvsCubit, PopularTvsState>(
        builder: (context, state) {
      if (state is PopularTvsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PopularTvsLoaded) {
        return TvList(state.result);
      } else if (state is PopularTvsError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    });
  }

  Widget _loadTopRatedTvList() {
    return BlocBuilder<TopRatedTvsCubit, TopRatedTvsState>(
        builder: (context, state) {
      if (state is TopRatedTvsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TopRatedTvsLoaded) {
        return TvList(state.result);
      } else if (state is TopRatedTvsError) {
        return Center(child: Text(state.message));
      } else {
        return Container();
      }
    });
  }
}
