import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/domain/usecases/get_movies_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;

  MovieBloc(this.getMovies) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is LoadMovies) {
      yield MovieLoading();
      try {
        final response = await getMovies(GetMoviesInput());
        yield response.fold((failure) => MovieFailure(failure.toString()), (movies) => MovieLoadSuccess(movies));
      } on DioError catch (e) {
        print(e.response!.statusCode);
        yield MovieFailure('Server Error!');
      } catch (e) {
        yield MovieFailure(e.toString());
      }
    }
  }
}
