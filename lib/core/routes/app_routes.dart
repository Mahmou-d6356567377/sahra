import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/view/screens/auth/login_screan/login_screan.dart';
import 'package:sahra/view/screens/auth/make_account_screan/make_account_screan.dart';
import 'package:sahra/view/screens/main_screens/movie_screen/movie_screan.dart';
import 'package:sahra/view/screens/main_screens/nav_main_screen/nav_main_screen.dart';
import 'package:sahra/view/screens/main_screens/web_screen.dart';

abstract class AppRoutes {
  static const nms = '/navigationmainscreen';
  static const ms2 = '/moviescreen';
  static const ws = '/webcreen';
  static const bas = '/buildaccountscreen';
  static const lns = '/loginscreen';

  static final GoRouter routers = GoRouter(initialLocation: nms, routes: [
    GoRoute(
      path: nms,
      builder: (BuildContext context, GoRouterState state) {
        return const NavMainScreen();
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
     GoRoute(
      path: bas,
      builder: (BuildContext context, GoRouterState state) {
        return const BuildAccountScrean();
      },
    ),
    GoRoute(
      path: lns,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScrean();
      },
    ),
  ]);
}
