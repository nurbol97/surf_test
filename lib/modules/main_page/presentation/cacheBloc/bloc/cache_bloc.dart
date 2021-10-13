import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_test/modules/main_page/data/model/movies_model.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';

part 'cache_event.dart';
part 'cache_state.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  CacheBloc() : super(CacheInitial());

  @override
  Stream<CacheState> mapEventToState(CacheEvent event) async* {
    if (event is SaveToCache) {
      bool saveCheck = false;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String encodedData = MoviesModel.encode(event.musics);
      saveCheck = await prefs.setString('movies', encodedData);

      if (saveCheck != false) {
        print('savedSuccsess');
        yield SavedToCacheSuccess();
      } else {
        yield CacheErrorState('Не получилось сохранить');
      }
    }
    if (event is GetFromCache) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: await_only_futures
      final String? moviesString = await prefs.getString('movies');

      final List<MoviesEntity>? movies = moviesString != null ? MoviesModel.decode(moviesString) : null;

      if (movies != null) {
        yield GetFromCacheSuccess(movies);
      } else {
        yield CacheErrorState('Ошибка вывода с кэша');
      }
    }
  }
}
