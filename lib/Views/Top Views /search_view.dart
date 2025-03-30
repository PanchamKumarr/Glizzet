import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/Views/Top%20Views%20/title_preview.dart';

import '../../logic/api_data/api_data_cubit.dart';
import '../../logic/api_data/api_data_state.dart';
import '../my_cell.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  TextEditingController searchQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchQuery.clear();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text(
              "Search",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return TextField(
                      controller: searchQuery,
                      onChanged: (value) {
                        final cubit = BlocProvider.of<SearchCubit>(context);
                        if (value.length >= 2) {
                          cubit.fetchMoviesOnDemand(value);
                        } else {
                          cubit.reset();
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none),
                        hintText: "Search for a Movie",
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.white,
                        suffixIcon: IconButton(
                          onPressed: () {
                            final cubit = BlocProvider.of<SearchCubit>(context);
                            cubit.reset();
                            searchQuery.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is PageLoadedState) {
                      return Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return MyCell(state.items[index]);
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 1,
                                color: Theme.of(context).dividerColor,
                              );
                            },
                            itemCount: state.items.length),
                      );
                    } else if (state is SearchLoadedState) {
                      return Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TitlePreview(state.items[index]),
                                    ));
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  // child: Text("cds"),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500/${state.items[index].posterPath}',
                                      fit: BoxFit.fill,
                                      height: 140,
                                      width: 102,
                                    ),
                                  )),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
