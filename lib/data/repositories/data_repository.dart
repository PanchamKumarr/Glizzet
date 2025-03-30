import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_first_app/data/Models/tmdb_models.dart';
import 'package:my_first_app/data/Models/yt_models.dart';
import 'package:my_first_app/data/repositories/API/api.dart';

class DataRepository {
  static const String baseURL = "https://api.themoviedb.org";
  static const String API_KEY = "61d7e7c56820803489dc7608a13b98bf";
  static const String baseURLyt =
      "https://youtube.googleapis.com/youtube/v3/search?";
  static const String API_KEYyt = "AIzaSyDahfQ1NhbzvZccik4ehezhx3tydSX4zUo";

  API api = API();

  List<Results> trendingMovies = [];
  List<Results> trendingTV = [];
  List<Results> popularMovies = [];
  List<Results> upcomingMovies = [];
  List<Results> topRated = [];
  Map<String, String> mp = {};
  Map<String, List<Results>> mpQ = {};

  Future<List<Results>> getTrendingMovies() async {
    if (trendingMovies.isNotEmpty == true) return trendingMovies;
    try {
      api.dio.options.baseUrl = baseURL;
      Response response =
          await api.sendRequest.get("/3/trending/movie/day?api_key=$API_KEY");
      Map<String, dynamic> dataMaps = response.data;
      trendingMovies = tmdbModel.fromJson(dataMaps).results ?? [];
      return trendingMovies;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Results>> getTrendingTV() async {
    if (trendingTV.isNotEmpty == true) return trendingTV;
    try {
      api.dio.options.baseUrl = baseURL;
      Response response =
          await api.sendRequest.get("/3/trending/tv/day?api_key=$API_KEY");
      Map<String, dynamic> dataMaps = response.data;
      trendingTV = tmdbModel.fromJson(dataMaps).results ?? [];
      return trendingTV;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Results>> getPopularMovies() async {
    if (popularMovies.isNotEmpty == true) return popularMovies;
    try {
      api.dio.options.baseUrl = baseURL;
      Response response = await api.sendRequest
          .get("/3/movie/popular?api_key=$API_KEY&language=en-US&page=1");
      Map<String, dynamic> dataMaps = response.data;
      popularMovies = tmdbModel.fromJson(dataMaps).results ?? [];
      return popularMovies;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Results>> getUpcomingMovies() async {
    if (upcomingMovies.isNotEmpty == true) return upcomingMovies;
    try {
      api.dio.options.baseUrl = baseURL;
      Response response = await api.sendRequest
          .get("/3/movie/upcoming?api_key=$API_KEY&language=en-US&page=1");
      Map<String, dynamic> dataMaps = response.data;
      upcomingMovies = tmdbModel.fromJson(dataMaps).results ?? [];
      return upcomingMovies;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Results>> getTopRatedMovies() async {
    if (topRated.isNotEmpty == true) return topRated;
    try {
      api.dio.options.baseUrl = baseURL;
      Response response = await api.sendRequest
          .get("/3/movie/top_rated?api_key=$API_KEY&language=en-US&page=1");
      Map<String, dynamic> dataMaps = response.data;
      topRated = tmdbModel.fromJson(dataMaps).results ?? [];
      return topRated;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Results>> getSearchWithQuery(String query) async {
    query.replaceAll(RegExp(r"\s+"), "%20");
    if (mpQ.containsKey(query)) {
      return mpQ[query] ?? [];
    }
    try {
      api.dio.options.baseUrl = baseURL;
      Response response = await api.sendRequest.get(
          "/3/search/movie?api_key=$API_KEY&query=$query&include_adult=false");
      Map<String, dynamic> dataMaps = response.data;
      mpQ[query] = tmdbModel.fromJson(dataMaps).results ?? [];
      return mpQ[query] ?? [];
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> getMovieWithQuery(String query) async {
    query.replaceAll(RegExp(r"\s+"), "%20");
    if (mp.containsKey(query)) {
      return mp[query] ?? "dQw4w9WgXcQ";
    }
    try {
      api.dio.options.baseUrl = baseURLyt;
      Response response = await api.sendRequest.get("q=$query&key=$API_KEYyt");
      Map<String, dynamic> dataMaps = response.data;
      String id = "dQw4w9WgXcQ";
      ytModel here = ytModel.fromJson(dataMaps);
      if (here.items != null && here.items![0].id != null) {
        id = here.items![0].id!.videoId ?? "dQw4w9WgXcQ";
      }
      mp[query] = id;
      return id;
    } catch (ex) {
      rethrow;
    }
  }
}
