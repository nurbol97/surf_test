import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_test/constants/colors/colors_styles.dart';
import 'package:surf_test/constants/text/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surf_test/modules/main_page/data/model/movies_model.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/presentation/bloc/movie_bloc.dart';

class MovieCardWidget extends StatelessWidget {
  // final String nameOfMovie;
  // final String movieImgUrl;
  // final String movieDescription;
  // final String movieReleaseDate;
  final MoviesEntity movie;
  const MovieCardWidget(
      // {required this.nameOfMovie,
      // required this.movieImgUrl,
      // required this.movieDescription,
      // required this.movieReleaseDate});

      {required this.movie});

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
                      movie.name,
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
                        movie.description,
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
                            movie.date,
                            style: TextStyles.grey_12_w500
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      BlocListener<MovieBloc, MovieState>(
                        listener: (context, state) {
                         
                        },
                        child: InkWell(
                          onTap: () {
                            print('added to fav');
                          },
                          child: Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: ColorStyles.app_blue_2443FF,
                          ),
                        ),
                      )
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
