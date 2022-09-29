import 'package:firebase_crud/firebase_services/splash_services.dart';
import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService _splashService = new SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashService.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Firebase Splash Screen'),
      ),
    );
  }
}
