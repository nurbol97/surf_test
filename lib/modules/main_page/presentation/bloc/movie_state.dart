part of 'movie_bloc.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieFailure extends MovieState {
  final String message;

  MovieFailure(this.message);
}

class MovieLoadSuccess extends MovieState {
  final List<MoviesEntity> movies;

  MovieLoadSuccess(this.movies);
}

class SearchSuccess extends MovieState {
  final List<MoviesEntity> movies;

  SearchSuccess(this.movies);
}
