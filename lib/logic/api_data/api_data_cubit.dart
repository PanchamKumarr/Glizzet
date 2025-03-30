import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_app/data/Models/tmdb_models.dart';
import 'package:my_first_app/data/Models/user.dart';
import 'package:my_first_app/data/repositories/data_repository.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

class DataCubit extends Cubit<DataState> {
  List<Results> trendingMovies = [];
  List<Results> trendingTV = [];
  List<Results> popularMovies = [];
  List<Results> upcomingMovies = [];
  List<Results> topRated = [];
  final DataRepository _dataRepository = GetIt.instance.get<DataRepository>();
  late List<List<Results>> list;

  DataCubit() : super(DataLoadingState()) {
    fetchData();
  }

  void fetchData() async {
    trendingMovies = await _dataRepository.getTrendingMovies();
    trendingTV = await _dataRepository.getTrendingTV();
    popularMovies = await _dataRepository.getPopularMovies();
    upcomingMovies = await _dataRepository.getUpcomingMovies();
    topRated = await _dataRepository.getTopRatedMovies();
    list = [
      trendingMovies,
      trendingTV,
      popularMovies,
      upcomingMovies,
      topRated
    ];
    emit(DataLoadedState(list));
  }
}

class PlayingCubit extends Cubit<PlayingState> {
  PlayingCubit() : super(PlayingLoadingState()) {
    fetchMovie();
  }
  final DataRepository _dataRepository = GetIt.instance.get<DataRepository>();

  void fetchMovie() async {
    List<Results> movies = await _dataRepository.getUpcomingMovies();
    emit(PlayingLoadedMovieState(movies));
  }

  void fetchTv() async {
    List<Results> tv = await _dataRepository.getTrendingTV();
    emit(PlayingLoadedTvState(tv));
  }
}

class YtCubit extends Cubit<YtState> {
  YtCubit(String title) : super(YtLoadingState()) {
    this.title = title;
    fetchVideo();
  }

  late String title;

  final DataRepository _dataRepository = GetIt.instance.get<DataRepository>();

  void fetchVideo() async {
    String id = await _dataRepository.getMovieWithQuery(title);
    emit(YtLoadedState(id));
  }
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(PageLoadingState()) {
    fetchVideo();
  }

  DataRepository _dataRepository = GetIt.instance.get<DataRepository>();

  void fetchVideo() async {
    emit(PageLoadingState());
    List<Results> items = await _dataRepository.getPopularMovies();
    emit(PageLoadedState(items));
  }

  void reset() {
    emit(PageLoadingState());
    fetchVideo();
  }

  void fetchMoviesOnDemand(String query) {
    emit(SearchLoadingState());
    getSearchedMovies(query);
  }

  void getSearchedMovies(String query) async {
    List<Results> items = await _dataRepository.getSearchWithQuery(query);
    emit(SearchLoadedState(items));
  }
}

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(NormalPageCreateAccount());

  final FirebaseAuth _firebaseAuth = GetIt.instance.get<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance.get<FirebaseFirestore>();

  void createAccount(String username, String name, String mobile, String email,
      String password, File? _photo) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    // firebase_storage.FirebaseStorage storage =
    //   firebase_storage.FirebaseStorage.instance;
    String downloadUrl = "";
    
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        if (_photo != null) {
          final fileName = basename(_photo.path);
          final destination = 'files/$fileName';
          print(fileName);
          print(destination);
          print(_photo);
          try {
            var snapshot = await firebaseStorage
                .ref()
                .child('images/imageName')
                .putFile(_photo);
            downloadUrl = await snapshot.ref.getDownloadURL();
            print(downloadUrl);
          } catch (e) {
            print('error occured');
          }
        }
        String userId = userCredential.user!.uid;
        Map<String, dynamic> newUser = {
          "username": username,
          "name": name,
          "mobile": mobile,
          "email": email,
          "downloadURL": downloadUrl,
          "watchList": []
        };
        try {
          await _firebaseFirestore.collection("users").doc(userId).set(newUser);
          final CurrentUser curretUser = GetIt.instance.get<CurrentUser>();
          curretUser
              .update(userId, username, name, mobile, email, downloadUrl, []);
          emit(AccountCreatedState());
        } catch (error) {
          emit(AccountCreationError(error.toString()));
        }
      }
    } catch (error) {
      emit(AccountCreationError(error.toString()));
    }
  }
}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(NormalPageSign());

  final FirebaseAuth _firebaseAuth = GetIt.instance.get<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance.get<FirebaseFirestore>();

  void signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      try {
        DocumentSnapshot userData = await _firebaseFirestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();
        final CurrentUser curretUser = GetIt.instance.get<CurrentUser>();
        String userii = userCredential.user!.uid;
        print("fwfaerfeq");
        print(userii);
        Map<String, dynamic> userMap = userData.data() as Map<String, dynamic>;
        curretUser.update(userii, userMap['username'], userMap['name'],
            userMap['mobile'], userMap['email'], userMap['downloadURL'], []);
        emit(SignInPassState());
        return;
      } catch (error) {
        print(error.toString());
        emit(SignInFailState(error.toString()));
        return;
      }
    } catch (error) {
      emit(SignInFailState(error.toString()));
    }
  }
}

class UserCheckCubit extends Cubit<UserCheckState> {
  UserCheckCubit() : super(CheckingUser()) {
    checkUser();
  }

  final FirebaseAuth _firebaseAuth = GetIt.instance.get<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance.get<FirebaseFirestore>();

  void checkUser() async {
    if (_firebaseAuth.currentUser == null) {
      emit(NotFoundUser());
      return;
    }

    String userId = _firebaseAuth.currentUser!.uid;

    DocumentSnapshot userData =
        await _firebaseFirestore.collection("users").doc(userId).get();
    final CurrentUser curretUser = GetIt.instance.get<CurrentUser>();

    Map<String, dynamic> userMap = userData.data() as Map<String, dynamic>;
    List<dynamic> dataMaps = userMap['watchList'];
    // List<Results> tm = tmdbModel.fromJson(dataMaps).results ?? [];

    curretUser.update(
        userId,
        userMap['username'].toString(),
        userMap['name'].toString(),
        userMap['mobile'].toString(),
        userMap['email'].toString(),
        userMap['downloadURL'].toString(), []);
    emit(FoundUser());
  }
}
