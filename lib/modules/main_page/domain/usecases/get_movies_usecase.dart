import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_test/core/error/failures.dart';
import 'package:surf_test/core/services/usecases/usecase.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/repositories/movies_repository.dart';

class GetMovies implements UseCase<List<MoviesEntity>, GetMoviesParams> {
  final MoviesRepository repository;

  GetMovies(this.repository);

  @override
  Future<Either<Failure, List<MoviesEntity>>> call(GetMoviesParams params) async {
    return await repository.getMovies(params);
  }
}

class GetMoviesParams extends Equatable {
  final int page;

  GetMoviesParams({required this.page});

  @override
  List<Object> get props => [];
}
