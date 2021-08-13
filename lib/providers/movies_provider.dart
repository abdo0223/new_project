import 'package:flutter/material.dart';
import 'package:roovies/models/TMDB_handler.dart';

import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlaying;
  List<Movie> moviesByGegre;
  List<Movie> trendingMovies;
  List<Movie> favorites = [];

  Future<bool> fetchNowPlaying() async {
    try {
      nowPlaying = await TMDBHandler.instance.getNowPlaying();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchMoviesByGenreId(int genreId) async {
    try {
      moviesByGegre = await TMDBHandler.instance.getMoviesByGenreId(genreId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      trendingMovies = await TMDBHandler.instance.getTreningMovies();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<MovieDetails> fetchMovieDetailsById(int movieId) async {
    try {
      return await TMDBHandler.instance.getMovieDetailsById(movieId);
    } catch (error) {
      return null;
    }
  }

  Future<String> fetchVideoKeyByMovieId(int moviId) async {
    try {
      return await TMDBHandler.instance.getVideoKeyByMovieId(moviId);
    } catch (error) {
      return null;
    }
  }

  Future<void> toggleFavoriteStatus(Movie movie) async {
    if (isFavorite(movie.id)) {
      favorites.removeWhere((element) => element.id == movie.id);
    } else {
      // await FireBaseHandler.instance.addFavorit(movie.id);
      favorites.add(movie);
    }

    notifyListeners();
  }

  bool isFavorite(int movieId) {
    return favorites.any((element) => element.id == movieId);
  }
}
