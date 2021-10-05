import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surf_test/constants/colors/colors_styles.dart';
import 'package:surf_test/constants/text/text_styles.dart';
import 'package:surf_test/modules/main_page/presentation/widget/movie_card.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController searchController = new TextEditingController();
  int symbolCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.app_black_222325,
      appBar: AppBar(
        backgroundColor: ColorStyles.app_black_222325,
        title: Container(
          width: double.infinity,
          height: 50.h,
          child: TextField(
            controller: searchController,
            onChanged: (String val) {
              setState(() {
                symbolCount = val.length;
              });
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(Icons.search, color: ColorStyles.app_blue_2443FF),
                onPressed: () {
                  print('hello');
                },
              ),
              suffixIcon: symbolCount > 0
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: ColorStyles.app_blue_2443FF,
                      ),
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          symbolCount = 0;
                        });
                      },
                    )
                  : null,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: 'Поиск по название фильма',
              hintStyle: TextStyles.grey_14_w500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            print('Hello');
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ListView(
                padding: EdgeInsets.only(bottom: 10),
                children: [
                  MovieCardWidget(
                    nameOfMovie: 'Аритмия 18+',
                    movieDescription: 'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                    movieImgUrl: '',
                    movieReleaseDate: '1 января 2017',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MovieCardWidget(
                    nameOfMovie: 'Аритмия 1asdadasasdasdads8+',
                    movieDescription: 'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                    movieImgUrl: '',
                    movieReleaseDate: '1 января 2017',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MovieCardWidget(
                    nameOfMovie: 'Аритмия 18+',
                    movieDescription: 'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                    movieImgUrl: '',
                    movieReleaseDate: '1 января 2017',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MovieCardWidget(
                    nameOfMovie: 'Аритмия 18+',
                    movieDescription: 'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                    movieImgUrl: '',
                    movieReleaseDate: '1 января 2017',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
