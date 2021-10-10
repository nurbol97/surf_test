part of 'movie_bloc.dart';

abstract class MovieEvent {}

class LoadMovies extends MovieEvent {}

class UpdateMovies extends MovieEvent {}

class SearchMovie extends MovieEvent {
  String query;
  SearchMovie(this.query);
}
