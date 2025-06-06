import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}
