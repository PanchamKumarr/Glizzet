import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_app/Views/Auth%20Views/login_view.dart';
import 'package:my_first_app/Views/Top%20Views%20/profile_view.dart';
import 'package:my_first_app/Views/Top%20Views%20/title_preview.dart';
import 'package:my_first_app/logic/api_data/api_data_cubit.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  static const List<String> categories = [
    "Trending Movies",
    "Trending Tv's",
    "Popular Movies",
    "Upcoming Movies",
    "Top Rated"
  ];

  final FirebaseAuth _firebaseAuth = GetIt.instance.get<FirebaseAuth>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, top: 60, bottom: 3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: AlertDialog(
                                          title: const Text("Logout"),
                                          content: const Text(
                                              "Are you Sure You want to Logout?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  _firebaseAuth.signOut();
                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginView()),
                                                  );
                                                },
                                                child: const Text("Yes")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("No"))
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.logout_rounded,
                                size: 23,
                              ),
                              label: const Text('Logout')),
                          const Spacer(),
                          const Text(
                            "Glizzet",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileView()),
                                );
                              },
                              icon: const Icon(
                                Icons.person,
                                size: 23,
                              ),
                              label: const Text('Profile')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        children: [
                          BlocBuilder<DataCubit, DataState>(
                            builder: (context, state) {
                              if (state is DataLoadedState) {
                                return Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500/${state.items[0][Random().nextInt(state.items[0].length - 1)].posterPath}"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Container(
                            height: 500,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.grey.withOpacity(0.2),
                                    // Colors.grey.withOpacity(0.0),
                                    Colors.black,
                                  ],
                                  stops: const [0.8, 1.0],
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StickyHeader(
                          header: Container(
                            width: double.infinity,
                            height: 42,
                            color: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(categories[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          content: Container(
                            height: 220.0,
                            // width: ,
                            child: BlocBuilder<DataCubit, DataState>(
                              builder: (context, state) {
                                if (state is DataLoadedState) {
                                  state.items[index].shuffle();
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.items[index].length,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index0) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TitlePreview(
                                                          state.items[index]
                                                              [index0])),
                                            );
                                          },
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              elevation: 10,
                                              // child: Text("cds"),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Image.network(
                                                  "https://image.tmdb.org/t/p/w500/${state.items[index][index0].posterPath}",
                                                  fit: BoxFit.fill,
                                                  height: 220,
                                                  width: 150,
                                                ),
                                              )

                                              // width: 100,
                                              ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ));
                    }),
              ],
            ),
          )),
    );
  }
}
