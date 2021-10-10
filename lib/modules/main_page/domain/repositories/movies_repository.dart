import 'package:dartz/dartz.dart';
import 'package:surf_test/core/error/failures.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/usecases/get_movies_usecase.dart';
import 'package:surf_test/modules/main_page/domain/usecases/search_movies_usecase.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<MoviesEntity>>> getMovies(GetMoviesParams params);
  Future<Either<Failure, List<MoviesEntity>>> searchMovies(SearchMoviesParams params);
}
