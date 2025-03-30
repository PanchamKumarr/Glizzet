import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_app/Views/Auth Views/forgot_password.dart';
import 'package:my_first_app/Views/Auth Views/login_view.dart';
import 'package:my_first_app/Views/Auth Views/register_view.dart';
import 'package:my_first_app/Views/Nav%20Bar/navigation_bar.dart';
import 'package:my_first_app/Views/Top%20Views%20/home_view.dart';
import 'package:my_first_app/Views/Top%20Views%20/profile_view.dart';
import 'package:my_first_app/Views/Top%20Views%20/title_preview.dart';
import 'package:my_first_app/data/Models/tmdb_models.dart';
import 'package:my_first_app/data/Models/user.dart';
import 'package:my_first_app/data/repositories/data_repository.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';

import 'firebase_options.dart';
import 'logic/api_data/api_data_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final getIt = GetIt.instance;
  getIt.registerSingleton<DataRepository>(DataRepository());
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<CurrentUser>(CurrentUser());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCheckCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          colorScheme: const ColorScheme.dark(),
        ),
        home: BlocConsumer<UserCheckCubit, UserCheckState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is CheckingUser) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FoundUser) {
              return const MyNavigationBar();
            } else {
              return LoginView();
            }
          },
        ),
      ),
    );
  }
}
