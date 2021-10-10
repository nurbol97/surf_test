import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surf_test/constants/colors/colors_styles.dart';
import 'package:surf_test/constants/text/text_styles.dart';
import 'package:surf_test/modules/main_page/domain/entity/movies_entity.dart';
import 'package:surf_test/modules/main_page/presentation/bloc/movie_bloc.dart';
import 'package:surf_test/modules/main_page/presentation/widget/movie_card.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController searchController = new TextEditingController();
  int symbolCount = 0;
  List<MoviesEntity> moviesList = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  @override
  void initState() {
    context.read<MovieBloc>().add(LoadMovies());
    super.initState();
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

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
            context.read<MovieBloc>().add(UpdateMovies());
          },
          child: BlocConsumer<MovieBloc, MovieState>(
            listener: (context, state) {
              if (state is MovieFailure) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                context.read<MovieBloc>().isFetching = false;
              }
              if (state is MovieLoadSuccess) {
                scrollToBottom();
                setState(() {
                  isLoading = false;
                });
              }
            },
            builder: (context, state) {
              if (state is MovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieFailure) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieLoadSuccess) {
                moviesList.addAll(state.movies);
                context.read<MovieBloc>().isFetching = false;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: moviesList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == moviesList.length) {
                          return !isLoading
                              ? Center(
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.refresh),
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        context.read<MovieBloc>().isFetching = true;
                                        context.read<MovieBloc>().add(LoadMovies());
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: 10,
                                  height: 30,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: CircularProgressIndicator(strokeWidth: 3.0)),
                                );
                        } else {
                          return InkWell(
                            onTap: () {
                              final snackBar = SnackBar(
                                content: Text('${moviesList[index].name}'),
                                duration: const Duration(milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: MovieCardWidget(
                              nameOfMovie: moviesList[index].name,
                              movieDescription: moviesList[index].description,
                              movieImgUrl: moviesList[index].imgUrl,
                              movieReleaseDate: moviesList[index].date,
                            ),
                          );
                        }
                      }),
                  // child: ListView(
                  //   padding: EdgeInsets.only(bottom: 10),
                  //   children: [
                  //     MovieCardWidget(
                  //       nameOfMovie: 'Аритмия 18+',
                  //       movieDescription:
                  //           'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                  //       movieImgUrl: '',
                  //       movieReleaseDate: '1 января 2017',
                  //     ),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     MovieCardWidget(
                  //       nameOfMovie: 'Аритмия 1asdadasasdasdads8+',
                  //       movieDescription:
                  //           'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                  //       movieImgUrl: '',
                  //       movieReleaseDate: '1 января 2017',
                  //     ),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     MovieCardWidget(
                  //       nameOfMovie: 'Аритмия 18+',
                  //       movieDescription:
                  //           'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                  //       movieImgUrl: '',
                  //       movieReleaseDate: '1 января 2017',
                  //     ),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     MovieCardWidget(
                  //       nameOfMovie: 'Аритмия 18+',
                  //       movieDescription:
                  //           'У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет',
                  //       movieImgUrl: '',
                  //       movieReleaseDate: '1 января 2017',
                  //     ),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //   ],
                  // ),
                );
              } else {
                return Center(
                  child: Text('Some Error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
