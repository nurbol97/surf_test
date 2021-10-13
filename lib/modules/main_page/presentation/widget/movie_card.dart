import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_test/constants/colors/colors_styles.dart';
import 'package:surf_test/constants/text/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surf_test/modules/main_page/data/model/movies_model.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/presentation/bloc/movie_bloc.dart';
import 'package:collection/collection.dart';
import 'package:surf_test/modules/main_page/presentation/cacheBloc/bloc/cache_bloc.dart';

class MovieCardWidget extends StatefulWidget {
  // final String nameOfMovie;
  // final String movieImgUrl;
  // final String movieDescription;
  // final String movieReleaseDate;
  final MoviesEntity movieCard;
  const MovieCardWidget(
      // {required this.nameOfMovie,
      // required this.movieImgUrl,
      // required this.movieDescription,
      // required this.movieReleaseDate});

      {required this.movieCard});

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<MoviesEntity> movies = [];
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      width: double.infinity,
      height: 220.h,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: NetworkImage('https://api.themoviedb.org$movieImgUrl'),
                  image: NetworkImage('https://b1.filmpro.ru/c/548013.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      widget.movieCard.name,
                      style: TextStyles.black_20_w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 120.h,
                      child: Text(
                        widget.movieCard.description,
                        style: TextStyles.grey_12_w500,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: ColorStyles.app_grey_C7C7C7,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.movieCard.date,
                            style: TextStyles.grey_12_w500.copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      BlocListener<CacheBloc, CacheState>(
                          listener: (context, state) {
                            if (state is GetFromCacheSuccess) {
                              movies = state.movies;
                              final movieFromCache =
                                  movies.firstWhereOrNull((movie) => movie.id == widget.movieCard.id);
                              if (movieFromCache != null) {
                                setState(() {
                                  isFavorite = true;
                                });
                              } else {
                                setState(() {
                                  isFavorite = false;
                                });
                              }
                            }
                            if (state is CacheErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(state.message),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: !isFavorite
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = true;
                                    });
                                    movies.add(widget.movieCard);
                                    context.read<CacheBloc>().add(SaveToCache(movies));
                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 18,
                                    color: ColorStyles.app_blue_2443FF,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = false;
                                    });
                                    movies.removeWhere((item) => item.id == widget.movieCard.id);
                                    context.read<CacheBloc>().add(SaveToCache(movies));
                                    print('added to fav');
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    size: 18,
                                    color: ColorStyles.app_blue_2443FF,
                                  ),
                                ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
