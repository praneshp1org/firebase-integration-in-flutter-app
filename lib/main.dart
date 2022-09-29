import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:firebase_crud/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // home: SplashScreen(),
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        // GetPage(name: "/home", page: () => HomePage())
      ],
    );
  }
}
