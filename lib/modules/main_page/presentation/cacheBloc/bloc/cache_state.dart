part of 'cache_bloc.dart';

abstract class CacheState {}

class CacheInitial extends CacheState {}

class SavedToCacheSuccess extends CacheState {}

class GetFromCacheSuccess extends CacheState {
  final List<MoviesEntity> movies;

  GetFromCacheSuccess(this.movies);
}

class CacheErrorState extends CacheState {
  final String message;
  CacheErrorState(this.message);
}
