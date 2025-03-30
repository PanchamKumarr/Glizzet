import 'package:flutter/material.dart';
import 'package:my_first_app/logic/api_data/api_data_cubit.dart';

import '../Top Views /download_view.dart';
import '../Top Views /home_view.dart';
import '../Top Views /now_playing_view.dart';
import '../Top Views /search_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    NowPlayingView(),
    SearchView(),
    // const DownloadView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(),
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill_outlined),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.download_done_outlined),
              //   label: 'Downloads',
              // ),
            ],
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.black,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5
            ),
      ),
    );
  }
}
