import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:surf_test/core/services/network/network_info.dart';
import 'package:surf_test/modules/main_page/data/datasources/movie_datasource.dart';
import 'package:surf_test/modules/main_page/data/repository/news_repository_impl.dart';
import 'package:surf_test/modules/main_page/domain/repositories/movies_repository.dart';
import 'package:surf_test/modules/main_page/domain/usecases/get_movies_usecase.dart';
import 'package:surf_test/modules/main_page/presentation/bloc/movie_bloc.dart';

final sl = GetIt.instance;

void setupInjections() {
  sl.registerFactory<Dio>(
    () => Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/discover/movie',
    )),
  );

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///Movies
  sl.registerLazySingleton<MovieDataSource>(
    () => MoviewDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => GetMovies(sl()));

  sl.registerFactory<MovieBloc>(
    () => MovieBloc(sl()),
  );
}
