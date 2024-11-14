import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/view/screens/main_screens/main_screen/main_screen.dart';

abstract class AppRoutes {

  static const ms = '/mainscreen';
 
  static final GoRouter routers = GoRouter(
    
    initialLocation: ms ,

    routes: [
      GoRoute(
        path: ms,
        builder: (BuildContext context, GoRouterState state) {
          return  MainScreen();
        },
      ),
    ]);
}