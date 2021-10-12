import 'package:equatable/equatable.dart';

class MoviesEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final String date;

  MoviesEntity(this.id, this.name, this.description, this.imgUrl, this.date);

  @override
  List<Object> get props => [id, name, description, imgUrl, date];
}
