import 'package:flutter/material.dart';
import 'feature/form/view/splashScreen.dart';

void main() => runApp(const AlgogaApp());

class AlgogaApp extends StatelessWidget {
  const AlgogaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Algoga',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashWrapper(),
    );
  }
}
