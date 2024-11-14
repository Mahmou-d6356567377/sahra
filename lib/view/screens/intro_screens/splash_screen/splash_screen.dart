import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/app_config/app_config.dart';
import 'package:sahra/data/sources/API/http_service.dart';
import 'package:sahra/data/sources/movie/movie_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitialComplete});
  final VoidCallback onInitialComplete;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((_) => _setUp(context).then((_) => widget.onInitialComplete()));
  }

  Future<void> _setUp(BuildContext _context) async {
    final getit = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getit.registerSingleton<AppConfig>(AppConfig(
        BASE_API_URL: 'BASE_API_URL',
        BASE_IMAGE_API_URL: 'BASE_IMAGE_API_URL',
        API_KEY: configData['API_KEY']));

    getit.registerSingleton<HTTPService>(HTTPService());
    getit.registerSingleton<MovieService>(MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "sahra",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(
              klogo,
            ),
          )),
        ),
      ),
    );
  }
}
