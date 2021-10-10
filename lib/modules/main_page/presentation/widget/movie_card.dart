import 'package:flutter/material.dart';
import 'package:surf_test/constants/colors/colors_styles.dart';
import 'package:surf_test/constants/text/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCardWidget extends StatelessWidget {
  final String nameOfMovie;
  final String movieImgUrl;
  final String movieDescription;
  final String movieReleaseDate;

  const MovieCardWidget(
      {required this.nameOfMovie,
      required this.movieImgUrl,
      required this.movieDescription,
      required this.movieReleaseDate});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      nameOfMovie,
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
                        movieDescription,
                        style: TextStyles.grey_12_w500,
                        textAlign: TextAlign.left,
                        maxLines: 10,
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
                            movieReleaseDate,
                            style: TextStyles.grey_12_w500.copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          print('added to fav');
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 18,
                          color: ColorStyles.app_blue_2443FF,
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
