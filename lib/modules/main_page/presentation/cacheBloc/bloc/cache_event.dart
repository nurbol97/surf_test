part of 'cache_bloc.dart';

abstract class CacheEvent {}

class SaveToCache extends CacheEvent {
  final List<MoviesEntity> musics;
  SaveToCache(this.musics);
}

class GetFromCache extends CacheEvent {}
