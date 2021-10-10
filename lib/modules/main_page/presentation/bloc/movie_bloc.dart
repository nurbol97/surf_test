import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/usecases/get_movies_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  int page = 1;
  bool isFetching = false;
  MovieBloc(this.getMovies) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is LoadMovies) {
      try {
        final response = await getMovies(GetMoviesParams(page: page));

        yield response.fold((failure) => MovieFailure(failure.toString()), (movies) {
          page++;
          return MovieLoadSuccess(movies);
        });
      } on DioError catch (e) {
        print(e.response!.statusCode);
        yield MovieFailure('Server Error!');
      } catch (e) {
        yield MovieFailure(e.toString());
      }
    }
    if (event is UpdateMovies) {
      yield MovieLoading();
      try {
        final response = await getMovies(GetMoviesParams(page: 1));

        yield response.fold(
          (failure) => MovieFailure(failure.toString()),
          (movies) => MovieLoadSuccess(movies),
        );
      } on DioError catch (e) {
        print(e.response!.statusCode);
        yield MovieFailure('Server Error!');
      } catch (e) {
        yield MovieFailure(e.toString());
      }
    }
  }
}
