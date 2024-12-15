import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/view/screens/main_screens/main_screen/main_screen.dart';
import 'package:sahra/view/screens/main_screens/movie_screen/movie_screan.dart';
import 'package:sahra/view/screens/main_screens/web_screen.dart';

abstract class AppRoutes {
  static const ms = '/mainscreen';
  static const ms2 = '/moviescreen';
  static const ws = '/webcreen';

  static final GoRouter routers = GoRouter(initialLocation: ms, routes: [
    GoRoute(
      path: ms,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: ms2,
      builder: (BuildContext context, GoRouterState state) {
        return const MovieScrean();
      },
    ),
    GoRoute(
      path: ws,
      builder: (BuildContext context, GoRouterState state) {
        return WebScreen(url: state.extra as String);
      },
    ),
  ]);
}
