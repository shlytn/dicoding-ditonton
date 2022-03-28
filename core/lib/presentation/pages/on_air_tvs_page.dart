import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
      ),
    );
  }
}
