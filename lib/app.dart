import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/core/route/app_router.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/controller/theme_controller/theme_controller_cubit.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeControllerCubit = getIt<ThemeControllerCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeControllerCubit, ThemeData>(
      bloc: themeControllerCubit,
      builder: (context, state) {
        return MaterialApp.router(
          theme: state,
          routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
          routerDelegate: getIt<AppRouter>().delegate(),
        );
      },
    );
  }
}
