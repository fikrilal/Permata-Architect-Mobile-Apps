import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      context.go("/LoginPage");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: 200,
        height: 160,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/company_logo.png"))),
      )),
    );
  }
}
