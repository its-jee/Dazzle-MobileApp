import 'package:flutter/material.dart';
import 'package:splash_screen_project/pages/home.dart';
import 'pages/Loginfirst.dart';
import 'pages/splash.dart';
// import 'pages/Loginfirst.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/homepage': (context) => HomePage(),
        '/ProductPage':(context) => Login(),
        
      },
    );
  }
}
