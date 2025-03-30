import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_app/data/Models/tmdb_models.dart';

abstract class DataState {}

class DataLoadingState extends DataState {}

class DataLoadedState extends DataState {
  final List<List<Results>> items;
  DataLoadedState(this.items);
}

class DataErrorState extends DataState {
  final String error;
  DataErrorState(this.error);
}

abstract class PlayingState {}

class PlayingLoadingState extends PlayingState {}

class PlayingLoadedMovieState extends PlayingState {
  final List<Results> items;
  PlayingLoadedMovieState(this.items);
}

class PlayingLoadedTvState extends PlayingState {
  final List<Results> items;
  PlayingLoadedTvState(this.items);
}

abstract class YtState {}

class YtLoadingState extends YtState {}

class YtLoadedState extends YtState {
  final String id;
  YtLoadedState(this.id);
}

abstract class SearchState {}

class PageLoadingState extends SearchState {}

class PageLoadedState extends SearchState {
  final List<Results> items;
  PageLoadedState(this.items);
}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Results> items;
  SearchLoadedState(this.items);
}

class CreateAccountState {}

class AccountCreatedState extends CreateAccountState {}

class NormalPageCreateAccount extends CreateAccountState {}

class AccountCreationError extends CreateAccountState {
  final String error;
  AccountCreationError(this.error);
}

class SignInState {}

class NormalPageSign extends SignInState {}

class SignInPassState extends SignInState {}

class SignInFailState extends SignInState {
  final String error;
  SignInFailState(this.error);
}

class UserCheckState {}

class CheckingUser extends UserCheckState {}

class FoundUser extends UserCheckState {}

class NotFoundUser extends UserCheckState {}
