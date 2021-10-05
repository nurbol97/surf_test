import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'modules/main_page/presentation/view/main_view.dart';

void main() {
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
      // builder: () => MultiBlocProvider(
      //   providers: [
      //     // BlocProvider<UserRegistBloc>(
      //     //   create: (_) => sl<UserRegistBloc>(),
      //     // ),
      //     // BlocProvider(create: (_) => sl<LoginBloc>()),
      //     // BlocProvider(create: (_) => sl<AuthBloc>()),
      //     // BlocProvider(create: (_) => sl<OrderAnswerExpressBloc>()),
      //     // BlocProvider(create: (_) => sl<CatalogBloc>()),
      //   ],
      // child: MaterialApp(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainView(),
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (_) => MainView());
        },
      ),
      // ),
    );
  }
}
