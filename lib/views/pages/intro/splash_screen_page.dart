import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 3000), () {
    //   context.go("/LoginPage");
    // });
    _checkLoginStatus();
    super.initState();
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Jika sudah login, arahkan ke dashboard
      Future.delayed(const Duration(milliseconds: 3000), () {
        context.go("/DashboardPage");
      });
    } else {
      // Jika belum login, arahkan ke login page
      Future.delayed(const Duration(milliseconds: 3000), () {
        context.go("/LoginPage");
      });
    }
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
