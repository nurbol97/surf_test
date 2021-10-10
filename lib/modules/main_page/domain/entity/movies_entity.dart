import 'package:equatable/equatable.dart';

class MoviesEntity extends Equatable {
  final String name;
  final String description;
  final String imgUrl;
  final String date;
  final bool isFavorite;

  MoviesEntity(this.name, this.description, this.imgUrl, this.date, this.isFavorite);

  @override
  List<Object> get props => [name, description, imgUrl, date, isFavorite];
}
