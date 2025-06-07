import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/bottom_navigation_screen.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/favorite_screen.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/main_screen.dart';


part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: BottomNavigationRoute.page,
      children: [
        AutoRoute(
          path: 'main',
          page: MainRoute.page,
        ),
        AutoRoute(
          path: 'favorite',
          page: FavoriteRoute.page,
        ),
      ],
    )
  ];
}
