import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/provider/on_air_tvs_notifier.dart';
import '../../presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit/tv/on_air_tvs_cubit.dart';

class OnAirTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv';

  @override
  State<OnAirTvsPage> createState() => _OnAirTvsPageState();
}

class _OnAirTvsPageState extends State<OnAirTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OnAirTvsCubit>().get());
        // Provider.of<OnAirTvsNotifier>(context, listen: false).fetchOnAirTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvsCubit, OnAirTvsState>(
          builder: (context, state) {
            if (state is OnAirTvsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvsLoaded) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is OnAirTvsError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
        // Consumer<OnAirTvsNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tv = data.tvs[index];
        //           return TvCard(tv);
        //         },
        //         itemCount: data.tvs.length,
        //       );
        //     } else {
        //       return Center(
        //         key: Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
