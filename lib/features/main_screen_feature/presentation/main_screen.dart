import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/core/theme/theme.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/controller/theme_controller/theme_controller_cubit.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/main_page.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final themeControllerCubit = getIt<ThemeControllerCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rick And Morty App',
          style: AppLightTextstyles.w700Text25,
        ),
        actions: [
          BlocBuilder<ThemeControllerCubit, ThemeData>(
            bloc:themeControllerCubit,
            builder: (context, state) {
              final IconData iconData = state == AppThemeData.lightTheme ?
              Icons.dark_mode_outlined :Icons.light_mode_outlined;

              return IconButton(
                onPressed: () {
                  themeControllerCubit.changeTheme();
                },
                icon:  Icon(
                    iconData,
                    size: 30,
                ),
              );
            },
          ),
        ],
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .secondary,
      ),
      body: MainPage(),
    );
  }
}
