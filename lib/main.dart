import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahra/bloc/get_PlayIngNow_cubits/get_play_iing_now_cubit.dart';
import 'package:sahra/bloc/get_movie_details_cubit/get_movie_details_cubit.dart';
import 'package:sahra/bloc/get_search_movies_cubit/get_seach_movie_cubit.dart';
import 'package:sahra/bloc/get_top_rated_cubit/get_top_rated_cubit_cubit.dart';
import 'package:sahra/bloc/get_upcoming_cubit/get_up_coming_cubit_cubit.dart';
import 'package:sahra/bloc/similer_movie_cubit/similermovies_cubit.dart';
import 'package:sahra/core/routes/app_routes.dart';
import 'package:sahra/core/service_locator/service_locator.dart';
import 'package:sahra/bloc/get_populer_cubits/getmovies_cubit.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo_IMPL.dart';
import 'package:sahra/view/screens/intro_screens/splash_screen/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();


  serviceLocator();

  runApp(SplashScreen(onInitialComplete: () {
    runApp(const MyApp());
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetmoviesCubit(getIt.get<MovieRepoImpl>())..fetchMovies(1),
        ),
        BlocProvider(
          create: (context) => GetUpComingCubitCubit(getIt.get<MovieRepoImpl>())
            ..fetchUpComingMovies(),
        ),
        BlocProvider(
          create: (context) => GetTopRatedCubitCubit(getIt.get<MovieRepoImpl>())
            ..fetchTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) => GetPlayIingNowCubit(getIt.get<MovieRepoImpl>())
            ..fetchPlayingNowMovies(),
        ),
         BlocProvider(
          create: (context) => GetMovieDetailsCubit(getIt.get<MovieRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => SimilermoviesCubit(getIt.get<MovieRepoImpl>()),
        ),
         BlocProvider(
          create: (context) => GetSeachMovieCubit(getIt.get<MovieRepoImpl>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          routerConfig: AppRoutes.routers,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
