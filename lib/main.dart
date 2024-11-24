import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahra/core/routes/app_routes.dart';
import 'package:sahra/view/screens/intro_screens/splash_screen/splash_screen.dart';

void main() {
  runApp(SplashScreen(
      key: UniqueKey(),
      onInitialComplete: () {
        runApp(const ProviderScope(child: MyApp()));
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: AppRoutes.routers,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
