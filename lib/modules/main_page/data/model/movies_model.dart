import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';

class MoviesModel extends MoviesEntity {
  MoviesModel({
    required String name,
    required String description,
    required String imgUrl,
    required String date,
    required bool isFavorite,
  }) : super(name, description, imgUrl, date, isFavorite);

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        name: json['title'],
        description: json['overview'],
        imgUrl: json['poster_path'],
        date: json['release_date'],
        isFavorite: false,
      );
}
