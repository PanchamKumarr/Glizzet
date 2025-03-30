import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_first_app/Views/my_cell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/data/repositories/data_repository.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';

import '../../data/Models/tmdb_models.dart';
import '../../logic/api_data/api_data_cubit.dart';

class NowPlayingView extends StatelessWidget {
  NowPlayingView({super.key}) {
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayingCubit(),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Upcoming",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<PlayingCubit, PlayingState>(
                          builder: (context, state) {
                            if (!(state is PlayingLoadedMovieState)) {
                              return TextButton(
                                onPressed: () {
                                  final cubit =
                                      BlocProvider.of<PlayingCubit>(context);
                                  if (state is PlayingLoadedTvState) {
                                    cubit.fetchMovie();
                                  }
                                },
                                child: const Text(
                                  "Movies",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              );
                            } else {
                              return TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Movies",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                          },
                        ),
                        const Spacer(),
                        BlocBuilder<PlayingCubit, PlayingState>(
                          builder: (context, state) {
                            if (!(state is PlayingLoadedTvState)) {
                              return TextButton(
                                onPressed: () {
                                  final cubit =
                                      BlocProvider.of<PlayingCubit>(context);
                                  if (state is PlayingLoadedMovieState) {
                                    cubit.fetchTv();
                                  }
                                },
                                child: const Text(
                                  "TV",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              );
                            } else {
                              return TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "TV",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<PlayingCubit, PlayingState>(
            builder: (context, state) {
              if (state is PlayingLoadedMovieState) {
                return ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      return MyCell(state.items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1,
                        color: Theme.of(context).dividerColor,
                      );
                    },
                    itemCount: state.items.length);
              } else if (state is PlayingLoadedTvState) {
                return ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      return MyCell(state.items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1,
                        color: Theme.of(context).dividerColor,
                      );
                    },
                    itemCount: state.items.length);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
