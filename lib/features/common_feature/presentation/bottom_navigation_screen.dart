import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';
import 'package:rick_morty_testapp/core/route/app_router.dart';

@RoutePage()
class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  final double paddingDouble = 15;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  double positionRightPadding = 0;

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBody: true,
      routes: [
        MainRoute(),
        FavoriteRoute(),
      ],
      animationDuration: const Duration(milliseconds: 150),
      bottomNavigationBuilder: (BuildContext context, TabsRouter tabRouter) {
        return Padding(
          padding: EdgeInsets.only(
            left: widget.paddingDouble,
            bottom: widget.paddingDouble,
            right: widget.paddingDouble,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: NavigationBar(

              onDestinationSelected: tabRouter.setActiveIndex,
              selectedIndex: tabRouter.activeIndex,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              indicatorColor: Theme.of(context).colorScheme.scrim,
              overlayColor: const WidgetStatePropertyAll<Color>(AppCommonColors.whiteColor30),
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home,
                    size: 35,
                    color: AppLightColors.blackColor,
                  ),
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  label: 'Characters',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.rectangle_outlined,
                    size: 35,
                    color: AppLightColors.blackColor,
                  ),
                  icon: Icon(
                    Icons.rectangle_outlined,
                    size: 35,
                  ),
                  label: 'Favorites',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


