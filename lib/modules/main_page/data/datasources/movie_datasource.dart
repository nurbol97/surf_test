import 'package:dio/dio.dart';
import 'package:surf_test/core/error/exceptions.dart';
import 'package:surf_test/modules/main_page/data/model/movies_model.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';

abstract class MovieDataSource {
  Future<List<MoviesEntity>> getMovies(int page);
  Future<List<MoviesEntity>> sarchMovies(int page, String query);
}

class MoviewDataSourceImpl implements MovieDataSource {
  final Dio dio;

  MoviewDataSourceImpl({required this.dio});
  Map<String, String> headers = {"Accept": "application/json", "Content-Type": "application/json"};
  @override
  Future<List<MoviesEntity>> getMovies(int page) async {
    try {
      var response = await dio.get(
        'https://api.themoviedb.org/3/discover/movie?api_key=6ccd72a2a8fc239b13f209408fc31c33&language=ru-RU&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: headers),
      );
      print(response);
      print('success state is: ${response.statusCode}');

      if (response.statusCode == 200) {
        {
          return (response.data['results'] as List).map((i) => MoviesModel.fromJson(i)).toList();
        }
      } else {
        ServerException();
        return [];
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<MoviesEntity>> sarchMovies(int page, String query) async {
    try {
      var response = await dio.get(
        'https://api.themoviedb.org/3/search/movie?api_key=6ccd72a2a8fc239b13f209408fc31c33&language=ru-RU&query=$query&page=$page&include_adult=false',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: headers),
      );
      print(response);
      print('success state is: ${response.statusCode}');

      if (response.statusCode == 200) {
        {
          return (response.data['results'] as List).map((i) => MoviesModel.fromJson(i)).toList();
        }
      } else {
        ServerException();
        return [];
      }
    } catch (e) {
      throw e;
    }
  }
}
