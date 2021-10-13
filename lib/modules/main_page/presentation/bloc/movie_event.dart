part of 'movie_bloc.dart';

abstract class MovieEvent {}

class LoadMovies extends MovieEvent {}

class UpdateMovies extends MovieEvent {}

class SearchMovie extends MovieEvent {
  String query;
  SearchMovie(this.query);
}

class SaveToCache extends MovieEvent {
  final List<MoviesEntity> musics;
  SaveToCache(this.musics);
}

class GetFromCache extends MovieEvent {}
