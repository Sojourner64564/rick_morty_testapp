import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/main_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rick And Morty App',
        ),
      ),
      body: const MainPage(),
    );
  }
}
