import 'package:dartz/dartz.dart';
import 'package:surf_test/core/error/failures.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<MoviesEntity>>> getMovies();
}
