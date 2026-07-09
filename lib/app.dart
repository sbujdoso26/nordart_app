import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/nordart_theme.dart';

class NordArtApp extends StatelessWidget {
  const NordArtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NordArt',
      debugShowCheckedModeBanner: false,
      theme: NordArtTheme.light,
      home: const SplashScreen(),
    );
  }
}