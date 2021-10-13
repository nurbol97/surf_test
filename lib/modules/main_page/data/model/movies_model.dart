import 'dart:convert';

import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';

class MoviesModel extends MoviesEntity {
  MoviesModel({
    required int id,
    required String name,
    required String description,
    required String imgUrl,
    required String date,
  }) : super(id, name, description, imgUrl, date);

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        id: json['id'],
        name: json['title'] ?? json['original_title'],
        description: json['overview'],
        imgUrl: json['poster_path'],
        date: json['release_date'],
      );


    static Map<String, dynamic> toMap(MoviesEntity movie) => {
        'id': movie.id,
        'title': movie.name,
        'overview': movie.description,
        'poster_path': movie.imgUrl,
        'release_date': movie.date,
      };

  static String encode(List<MoviesEntity> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movies) => MoviesModel.toMap(movies))
            .toList(),
      );

  static List<MoviesEntity> decode(String movie) =>
      (json.decode(movie) as List<dynamic>)
          .map<MoviesEntity>((item) => MoviesModel.fromJson(item))
          .toList();    
}
