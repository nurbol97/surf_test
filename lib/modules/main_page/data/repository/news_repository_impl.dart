import 'package:surf_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:surf_test/core/services/network/network_info.dart';
import 'package:surf_test/modules/main_page/data/datasources/movie_datasource.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<MoviesEntity>>> getMovies() async {
    if (await networkInfo.isConnected) {
      try {
        print('Repository IMPL MOVIES GET');
        final movies = await remoteDataSource.getMovies();
        return Right(movies);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}