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
  List<MoviesEntity> searchList = [];
  ScrollController scrollControllerForSearcg = ScrollController();
  bool isLoading = false;
  @override
  void initState() {
    context.read<MovieBloc>().add(LoadMovies());
    super.initState();
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
            onSubmitted: (String val) {},
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
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Проверьте соединение с интернетом и попробуйте еще раз! ${state.message}')));
                context.read<MovieBloc>().isFetching = false;
              }
              if (state is MovieLoadSuccess) {
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
                  child: Text(state.message),
                );
              } else if (state is MovieLoadSuccess) {
                moviesList.addAll(state.movies);
                context.read<MovieBloc>().isFetching = false;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView.builder(
                      controller: scrollController,
                      // ..addListener(() {
                      //   if (scrollController.position.atEdge) {
                      //     if (scrollController.position.pixels != 0) {
                      //       context.read<MovieBloc>().isFetching = true;
                      //       context.read<MovieBloc>().add(LoadMovies());
                      //     }
                      //   }
                      // }),
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
                                        Timer(Duration(milliseconds: 30), () {
                                          scrollController.jumpTo(scrollController.position.maxScrollExtent);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
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
                );
              } else if (state is SearchSuccess) {
                searchList.addAll(state.movies);
                context.read<MovieBloc>().isFetching = false;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView.builder(
                      controller: scrollController,
                      // ..addListener(() {
                      //   if (scrollController.position.atEdge) {
                      //     if (scrollController.position.pixels != 0) {
                      //       context.read<MovieBloc>().isFetching = true;
                      //       context.read<MovieBloc>().add(LoadMovies());
                      //     }
                      //   }
                      // }),
                      shrinkWrap: true,
                      itemCount: searchList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == searchList.length) {
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
                                        Timer(Duration(milliseconds: 30), () {
                                          scrollController.jumpTo(scrollController.position.maxScrollExtent);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        } else {
                          return InkWell(
                            onTap: () {
                              final snackBar = SnackBar(
                                content: Text('${searchList[index].name}'),
                                duration: const Duration(milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: MovieCardWidget(
                              nameOfMovie: searchList[index].name,
                              movieDescription: searchList[index].description,
                              movieImgUrl: searchList[index].imgUrl,
                              movieReleaseDate: searchList[index].date,
                            ),
                          );
                        }
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
