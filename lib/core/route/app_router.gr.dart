// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BottomNavigationScreen]
class BottomNavigationRoute extends PageRouteInfo<void> {
  const BottomNavigationRoute({List<PageRouteInfo>? children})
      : super(BottomNavigationRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BottomNavigationScreen();
    },
  );
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<FavoriteRouteArgs> {
  FavoriteRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          args: FavoriteRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FavoriteRouteArgs>(
        orElse: () => const FavoriteRouteArgs(),
      );
      return FavoriteScreen(key: args.key);
    },
  );
}

class FavoriteRouteArgs {
  const FavoriteRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'FavoriteRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FavoriteRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          args: MainRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainRouteArgs>(
        orElse: () => const MainRouteArgs(),
      );
      return MainScreen(key: args.key);
    },
  );
}

class MainRouteArgs {
  const MainRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}
