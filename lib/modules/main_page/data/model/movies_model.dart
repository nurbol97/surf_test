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
}
