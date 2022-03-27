import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/cubit/watchlist_tv_cubit.dart';

class WatchlistTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvsPageState createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistTvCubit>().get());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvCubit>().get();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistTvCubit, WatchlistTvState>(
        builder: (context, state) {
      if (state is WatchlistTvLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is WatchlistTvHasData) {
        final result = state.result;
        return ListView.builder(
          itemBuilder: (context, index) {
            final tv = result[index];
            return TvCard(tv);
          },
          itemCount: result.length,
        );
      } else if (state is WatchlistTvError) {
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
