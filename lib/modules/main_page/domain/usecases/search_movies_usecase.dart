import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_test/core/error/failures.dart';
import 'package:surf_test/core/services/usecases/usecase.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/repositories/movies_repository.dart';

class SearchMovies implements UseCase<List<MoviesEntity>, SearchMoviesParams> {
  final MoviesRepository repository;

  SearchMovies(this.repository);

  @override
  Future<Either<Failure, List<MoviesEntity>>> call(SearchMoviesParams params) async {
    return await repository.searchMovies(params);
  }
}

class SearchMoviesParams extends Equatable {
  final int page;
  final String query;
  SearchMoviesParams({required this.page, required this.query});

  @override
  List<Object> get props => [];
}
