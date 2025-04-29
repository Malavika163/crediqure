import 'package:crediqure/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            primary: Color(0xff111184), seedColor: Colors.black),
        useMaterial3: true,
      ),
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

