import 'package:flutter/material.dart';
import 'package:sahra/core/constants/constants_properties.dart';

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
        .then((_) => widget.onInitialComplete());
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
              image: AssetImage(klogo),
            ),
          ),
        ),
      ),
    );
  }
}
