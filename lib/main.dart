import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'core/utils/injection_container.dart';
import 'modules/main_page/presentation/bloc/movie_bloc.dart';
import 'modules/main_page/presentation/cacheBloc/bloc/cache_bloc.dart';
import 'modules/main_page/presentation/view/main_view.dart';

void main() {
  setupInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<MovieBloc>()),
          BlocProvider(create: (_) => CacheBloc()),
        ],
        child: MaterialApp(
          // builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainView(),
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(builder: (_) => MainView());
          },
        ),
      ),
    );
  }
}
