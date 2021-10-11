import 'package:surf_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:surf_test/core/services/network/network_info.dart';
import 'package:surf_test/modules/main_page/data/datasources/movie_datasource.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/repositories/movies_repository.dart';
import 'package:surf_test/modules/main_page/domain/usecases/get_movies_usecase.dart';
import 'package:surf_test/modules/main_page/domain/usecases/search_movies_usecase.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<MoviesEntity>>> getMovies(GetMoviesParams params) async {
    if (await networkInfo.isConnected) {
      try {
        print('Repository IMPL MOVIES GET');
        final movies = await remoteDataSource.getMovies(params.page);
        return Right(movies);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoviesEntity>>> searchMovies(SearchMoviesParams params) async {
    if (await networkInfo.isConnected) {
      try {
        print('Repository IMPL MOVIES Search');
        final moviesSearch = await remoteDataSource.searchMovies(params.page, params.query);
        return Right(moviesSearch);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
