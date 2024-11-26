import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahra/core/routes/app_routes.dart';
import 'package:sahra/core/service_locator/service_locator.dart';
import 'package:sahra/data/cubits/getmovies_cubit.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo_IMPL.dart';
import 'package:sahra/view/screens/intro_screens/splash_screen/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();

  runApp(SplashScreen(onInitialComplete: (){
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
